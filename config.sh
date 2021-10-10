#!/bin/bash

set -e

usage() {
    echo "Usage: $0 [OPTION]"
    echo
    echo "OPTIONS:"
    echo "   --apply     Apply configs to the system. If a config already"
    echo "               exists, the script will abort without making any"
    echo "               changes."
    echo
    echo "   --force     Apply configs to the sytem without aborting when"
    echo "               configs already exist. Configs that already"
    echo "               exist will be backed up."
    echo
    echo "   --update    Use the configs the system already has to update"
    echo "               the configs used by this script."
    echo
    echo "   --restore   Restore previous configs from backup."
    echo
    echo "   --delete    Delete backup of previous configs."
}

if [ "$#" -ne 1 ]; then
    usage
    exit 0
fi


backup_dir="$HOME/.cache/config_backup"


error() {
    echo
    echo "Error(s) found, aborted."
}

success() {
    echo
    echo "Command completed successfully"
}

case "$1" in
    "--force")
        force=1
        ;;
    "--delete")
        delete_backup=1
        ;;
    "--update")
        update=1
        ;;
    "--restore")
        restore=1
        ;;
    "--apply")
        ;;
    *)
        usage
        exit 1
        ;;
esac


if [ -n "$delete_backup" ]; then
    echo "REMOVING CONFIG BACKUPS"
    if [ ! -d "$backup_dir" ]; then
        echo "No backup directory found" > /dev/stderr
        exit 1
    fi

    echo "Removing $backup_dir"
    rm -rf "$backup_dir" || (error && exit 1)

    success
    exit 0
fi


configs=()
config_paths=()
missing_configs=()

add_config() {
    if [ -e "$1" ]; then
        missing_configs+=("0")
    else
        missing_config=1
        missing_configs+=("1")
        echo "./$1 is missing"
    fi
    configs+=("$1")

    directory=$(dirname "$2")
    if [ ! -d "$directory" ]; then
        if [ -e "$directory" ]; then
            read -p "$2 exists and is not a directory, delete? y/n " choice
            if [[ "$choice" != "y" ]]; then
                echo "Aborted"
                exit 0
            fi
            echo "Removing $directory"
            rm -rf "$directory" || (error && exit 1)
        fi
        echo "Creating directory $directory"
        mkdir -p "$directory" || (error && exit 1)
    fi

    config_paths+=("$2")
}

echo "VALIDATING CONFIGS"
add_config "vim/vimrc"                   "$HOME/.vim/vimrc"
add_config "vim/vimpagerrc"              "$HOME/.vim/vimpagerrc"
add_config "vim/colors/custom.vim"       "$HOME/.vim/colors/custom.vim"
add_config "vim/autoload/plug.vim"       "$HOME/.vim/autoload/plug.vim"
add_config "vim/after/syntax/c.vim"      "$HOME/.vim/after/syntax/c.vim"
add_config "vim/after/syntax/python.vim" "$HOME/.vim/after/syntax/python.vim"
add_config "vim/after/syntax/java.vim"   "$HOME/.vim/after/syntax/java.vim"
add_config "vim/after/syntax/sh.vim"     "$HOME/.vim/after/syntax/sh.vim"
add_config "vim/after/syntax/tmux.vim"   "$HOME/.vim/after/syntax/tmux.vim"
add_config "vim/after/syntax/vim.vim"    "$HOME/.vim/after/syntax/vim.vim"
add_config "vim/after/ftplugin/c.vim"    "$HOME/.vim/after/ftplugin/c.vim"
add_config "tmux.conf"                   "$HOME/.tmux.conf"
add_config "bashrc"                      "$HOME/.bashrc"
add_config "inputrc"                     "$HOME/.inputrc"
add_config "dir_colors"                  "$HOME/.dir_colors"
[ ! -v missing_config ] && echo "All configs found."

n_configs=${#config_paths[@]}

if [ "$n_configs" -eq 0 ]; then
    echo "No config files found" > /dev/stderr
    error
    exit 1
fi


if [ -n "$update" ]; then
    echo
    echo "UPDATING CONFIGS"

    for ((i = 0; i < n_configs; i++)); do
        config="${configs[i]}"
        conf_path="${config_paths[i]}"
        if [ -e "$conf_path" ]; then
            if [ -e "./$config" ]; then
                echo "Removing ./$config"
                rm -rf "./$config" || (error && exit 1)
            else
                directory=$(dirname "./$config")
                if [ ! -d "$directory" ]; then
                    echo "Creating $directory"
                    mkdir -p "$directory" || (error && exit 1)
                fi
            fi
            echo "Copying $conf_path to ./$config"
            cp -r "$conf_path" "./$config" || (error && exit 1)
        fi
    done

    success;
    exit 0
fi

if [ -n "$restore" ]; then
    echo
    echo "RESTORING CONFIG BACKUPS"
    if [ ! -d "$backup_dir" ]; then
        echo "No backup directory found" > /dev/stderr
        error
        exit 1
    fi

    for ((i = 0; i < n_configs; i++)); do
        config="${configs[i]}"
        conf_path="${config_paths[i]}"
        conf_backup="$backup_dir/$config"

        if [ -e "$conf_backup" ]; then
            restored=1
            if [ -e "$conf_path" ]; then
                echo "Removing $conf_path"
                rm -rf "$conf_path" || (error && exit 1)
            fi
            echo "Moving $conf_backup to $conf_path"
            mv "$conf_backup" "$conf_path" || (error && exit 1)
        fi
    done

    [ -z "$restored" ] && echo "No config backups found"

    echo "Removing $backup_dir"
    rm -rf "$backup_dir" || (error && exit 1)

    success
    exit 0
fi

if [ -v missing_config ]; then
    echo
    read -p "Config(s) are missing, skip them and continue? y/n " choice
    if [[ "$choice" != "y" ]]; then
        echo "Aborted"
        exit 0
    fi
fi

echo
echo "SCANNING EXISTING CONFIGS"

for ((i = 0; i < n_configs; i++)); do
    config="${configs[i]}"
    conf_path="${config_paths[i]}"
    missing_config="${missing_configs[i]}"

    if [[ "$missing_config" == "0" ]]; then
        if [ -e "$conf_path" ]; then
            echo "$conf_path exists."
            error_flag=1
        fi
    fi
done
if [ -v error_flag ]; then
    if [ -z "$force" ]; then
        error
        exit 1
    else
        echo
        echo "BACKING UP OLD CONFIGS"

        if [ -d "$backup_dir" ]; then
            read -p "Config backup exists, delete? y/n " choice
            if [[ "$choice" != "y" ]]; then
                echo "Aborted"
                exit 0
            fi
            echo "Removing directory $backup_dir"
            rm -rf "$backup_dir" || (error && exit 1)
        fi

        for ((i = 0; i < n_configs; i++)); do
            config="${configs[i]}"
            conf_path="${config_paths[i]}"
            missing_config="${missing_configs[i]}"

            if [[ "$missing_config" == "0" ]]; then
                if [ -e "$conf_path" ]; then
                    directory=$(dirname "$backup_dir/$config")
                    if [ ! -d "$directory" ]; then
                        echo "Creating directory $directory"
                        mkdir -p "$directory" || (error && exit 1)
                    fi
                    echo "Moving $conf_path to $backup_dir/$config"
                    mv "$conf_path" "$backup_dir/$config" || (error && exit 1)
                fi
            fi
        done
    fi
else 
    echo "No existing config files found"
fi

echo
echo "APPLYING CONFIGS"

for ((i = 0; i < n_configs; i++)); do
    config="${configs[i]}"
    conf_path="${config_paths[i]}"
    missing_config="${missing_configs[i]}"
    if [[ "$missing_config" == "0" ]]; then
        echo "Copying ./$config to $conf_path"
        cp -r "./$config" "$conf_path" || (error && exit 1)
    fi
done

success
