#!/bin/bash

set -e

usage() {
    echo "Usage: $0 [OPTION]"
    echo
    echo "OPTIONS:"
    echo "   --apply         Backup existing configs and then apply configs"
    echo "                   found in $CONFIG_LIST_FILE to the system."
    echo
    echo "   --backup        Backup existing configs without applying"
    echo "                   any changes."
    echo
    echo "   --update        Use existing configs to update configs found"
    echo "                   in $CONFIG_LIST_FILE."
    echo
    echo "   --restore       Restore existing configs from backup and delete"
    echo "                   any files/dirs that did not exist previously."
    echo
    echo "   --safe-restore  Restore existing configs from backup but do not"
    echo "                   delete anything."
    echo
    echo "   --delete        Delete backup of existing configs."
}

error_flag=0
error() {
    error_flag=1
    echo "ERROR: $1" > /dev/stderr
}


read_config_list() {
    echo "Reading $CONFIG_LIST_FILE..."
    if [[ ! -f "$CONFIG_LIST_FILE" ]]; then
        error "$CONFIG_LIST_FILE not found"
        return
    fi

    sources=( $(awk '/^\s*[^# \t]/{print $1}' "$CONFIG_LIST_FILE") )
    dests=( $(awk '/^\s*[^# \t]/{print $2}' "$CONFIG_LIST_FILE") )

    N_CONFIGS="${#sources[@]}"

    # expand dest (eg. $HOME -> /home/user/)
    for ((i = 0; i < N_CONFIGS; i++)); do
        dests[$i]=$(eval echo "${dests[i]}")
    done

    [[ "$error_flag" == 0 ]] && echo "No errors found."
}

validate_sources() {
    echo
    echo "Validating sources..."
    validated=()
    for ((i = 0; i < N_CONFIGS; i++)); do
        src="${sources[i]}"

        is_dupe=0
        for v_src in "${validated[@]}"; do
            if [[ "$v_src" == "$src" ]]; then
                is_dupe=1
                break
            fi
        done
        [[ "$is_dupe" == 1 ]] && continue

        is_duped=0
        for ((j = i+1; j < N_CONFIGS; j++)); do
            if [[ "$src" == "${sources[j]}" ]]; then
                is_duped=1
                break
            fi
        done

        if [[ "$is_duped" == 1 ]]; then
            error "$src is duplicated"
        fi

        if [[ ! "$src" =~ ^(\/?[a-zA-Z0-9_.-])+$ ]]; then
            error "$src is not a valid path"
        elif [[ ! -e "$src" ]]; then
            error "$src does not exist"
        elif [[ ! -f "$src" ]]; then
            error "$src is not a file"
        fi
        validated+=("$src")
    done

    [[ "$error_flag" == 0 ]] && echo "No errors found."
}

validate_dests() {
    echo
    echo "Validating destinations..."
    validated=()
    for ((i = 0; i < N_CONFIGS; i++)); do
        dest="${dests[i]}"

        is_dupe=0
        for v_dest in "${validated[@]}"; do
            if [[ "$v_dest" == "$dest" ]]; then
                is_dupe=1
                break
            fi
        done
        [[ "$is_dupe" == 1 ]] && continue

        is_duped=0
        for ((j = i+1; j < N_CONFIGS; j++)); do
            if [[ "$dest" == "${dests[j]}" ]]; then
                is_duped=1
                break
            fi
        done


        if [[ "$is_duped" == 1 ]]; then
            error "$dest is duplicated"
        fi

        if [[ ! "$dest" =~ ^(\/?[a-zA-Z0-9_.-])+$ ]]; then
            error "$dest is not a valid path"
        elif [[ -e "$dest" ]]; then
            if [[ -f "$dest" ]]; then
                if [[ ! -w "$dest" ]]; then
                    error "$dest exists but is not writable"
                fi
            else
                error "$dest exists but is not a file"
            fi
        else
            parent=$(dirname "$dest")
            while true; do
                if [[ -e "$parent" ]]; then
                    if [[ -d "$parent" ]]; then
                        if [[ -w "$parent" ]]; then
                            break
                        else
                            error "$dest does not exist and cannot be created since $parent is not writable"
                            break
                        fi
                    fi
                    error "$dest does not exist and cannot be created since $parent is not a directory"
                    break
                fi
                parent=$(dirname "$parent")
            done
        fi
        validated+=("$dest")
    done

    [[ "$error_flag" == 0 ]] && echo "No errors found."
}




create_dirs_helper() {
    local parent=$(dirname "$1")
    local path=$2

    if [[ -e "$parent" ]]; then
        if [[ ! -d "$parent" ]]; then
            error "Cannot create $path since $parent exists and is not a directory"
            exit 1
        elif [[ ! -w "$parent" ]]; then
            error "Cannot create $path since $parent exists and is not writable"
            exit 1
        fi
    else
        create_dirs_helper "$parent" "$path"
        echo "$parent"
        mkdir "$parent"
    fi
}

create_dirs() {
    path="$1"
    if [[ -e "$path" ]]; then
        if [[ ! -d "$path" ]]; then
            error "Cannot create $path since it exists and is not a directory"
            exit 1
        fi
    else
        create_dirs_helper "$path" "$path"
        echo "$path"
        mkdir "$path"
    fi
}

backup_dests() {
    echo
    echo "Backing up configs..."

    if [[ -e "$BACKUP_DIR" ]]; then
        printf "A backup already exists. Delete? (y/N) "
        read response
        case "$response" in
            "y" | "yes" | "Y" | "Yes" | "YES")
                rm -rf "$BACKUP_DIR"
                ;;
            *)
                echo "Aborted."
                exit 0
                ;;
        esac
    fi

    create_dirs "$BACKUP_DIR" > /dev/null

    for ((i = 0; i < N_CONFIGS; i++)); do
        dest="$BACKUP_DIR/${sources[i]}"
        src="${dests[i]}"
        if [[ -e "$src" ]]; then
            mkdir -p "$(dirname "$dest")"
            cp "$src" "$dest"
        fi
    done
    echo "Configs backed up to $BACKUP_DIR."
}

apply_sources() {
    echo
    echo "Applying sources..."
    for ((i = 0; i < N_CONFIGS; i++)); do
        parent=$(dirname "${dests[i]}")
        if [[ ! -e "$parent" ]]; then
            created_files+=( $(create_dirs "$parent") )
        fi
        if [[ ! -e "${dests[i]}" ]]; then
            created_files+=("${dests[i]}")
        fi
        cp "${sources[i]}" "${dests[i]}"
    done
    echo "Done."
}

restore_backup() {
    echo
    echo "Restoring backup..."

    if [[ ! -e "$BACKUP_DIR" ]]; then
        error "No backup directory exists"
        exit 1
    elif [[ ! -d "$BACKUP_DIR" ]]; then
        error "$BACKUP_DIR is not a directory"
        exit 1
    fi

    for ((i = 0; i < N_CONFIGS; i++)); do
        if [[ -e "$BACKUP_DIR/${sources[i]}" ]]; then
            cp "$BACKUP_DIR/${sources[i]}" "${dests[i]}"
        fi
    done
    echo "Done."
}

update_sources() {
    echo
    echo "Updating sources..."
    for ((i = 0; i < N_CONFIGS; i++)); do
        parent=$(dirname "${sources[i]}")
        if [[ ! -e "$parent" ]]; then
            create_dirs "$parent" > /dev/null
        fi
        cp "${dests[i]}" "${sources[i]}"
    done
    echo "Done."
}

delete_backup() {
    echo "Deleting backup directory..."
    if [[ -e "$BACKUP_DIR" ]]; then
        rm -rf "$BACKUP_DIR"
    else
        error "No backup directory exists"
        exit 1
    fi
    echo "Done."
}

validate_all() {
    read_config_list
    if [[ "$error_code" == 1 ]]; then
        exit 1;
    fi
    validate_sources
    validate_dests
    if [[ "$error_code" == 1 ]]; then
        exit 1;
    fi
}

delete_introduced_files() {
    if [[ -f "$INTRO_FILE" ]]; then
        intro_files=( $(cat "$INTRO_FILE" ) )
        length="${#intro_files[@]}"
        for ((i = $length - 1; i >= 0; i--)); do
            file="${intro_files[i]}"

            if [[ -e "$file" ]]; then
                if [[ -f "$file" ]]; then
                    rm "$file"
                elif [[ -d "$file" ]]; then
                    rmdir "$file"
                else
                    error "$file is neither file nor directory"
                    exit 1
                fi
            fi
        done
    fi
}


CONFIG_LIST_FILE="configs.txt"
BACKUP_DIR="$HOME/.cache/config_backup"
INTRO_FILE="$BACKUP_DIR/.introduced_files.txt"
created_files=()

[[ "$#" != 1 ]] && usage && exit 1

case $1 in
    "--apply" | "-a")
        validate_all
        backup_dests
        apply_sources
        for created_file in "${created_files[@]}"; do
            echo "$created_file" >> "$BACKUP_DIR/.introduced_files.txt"
        done
        ;;
    "--backup" | "-b")
        validate_all
        backup_dests
        ;;
    "--restore" | "-r")
        validate_all
        restore_backup
        delete_introduced_files
        ;;
    "--safe-restore" | "-s")
        validate_all
        restore_backup
        ;;
    "--update" | "-u")
        validate_all
        update_sources
        ;;
    "--delete" | "-d")
        delete_backup
        ;;
    "--help" | "-h")
        usage
        exit 0
        ;;
    *)
        usage
        exit 1
        ;;
esac

