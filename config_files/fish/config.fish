set PPID $fish_pid

set -x EDITOR vim
set -x PAGER  vimpager

function fish_prompt
    if [ (string split '' $history[1])[1] = "#" ]
        echo all | history delete --prefix "#" >/dev/null
    end
    printf '%s $ ' (basename $PWD)
end

function fish_title
    if [ $_ = "fish" ]
        printf '%s' (basename $PWD)
    else
        printf '%s' $_ 
    end
end

function fish_mode_prompt
    # no vi mode indicator
end

function fish_greeting
    # no greeting
end

if status is-interactive
    [ -d $HOME/.bin ] && set -x PATH "$HOME/.bin:$PATH"
    [ -d $HOME/.cargo/bin ] && set -x PATH "$HOME/.cargo/bin:$PATH"

    set -x NODE_OPTIONS "--openssl-legacy-provider"

    fnm env --use-on-cd | source

    set fish_color_command normal
    set fish_color_param normal
    set fish_color_end normal
    set fish_color_autosuggestion brblack
    set fish_color_comment brblack
    set fish_color_error red
    set fish_color_quote green
    set fish_pager_color_progress white

    # remove path underlining
    set fish_color_valid_path

    # remove parent directory prefix from suggestions
    # just sets color to bg color so it disappears
    # this "feature" is just annoying noise
    set fish_pager_color_prefix "#1b1b20"


    set __smart_join_path (dirname (status --current-filename))"/smart_join.py"

    function __condense_commandline
        # this function condenses a multi-line command
        # into a single line with '; ' separation.
        commandline | fish_indent -i | $__smart_join_path
    end


    # custom hook called when ctrl+c is pressed
    function __on_press_ctrl_c
        set cmd (commandline)

        if [ (string trim "$cmd") = "" ]
            printf "\n\n"
            commandline ""
            commandline -f repaint
        else
            commandline "# "(__condense_commandline)
            commandline -f execute

            # set n_lines (count $cmd)
            # set line_no (commandline -L)

            # # move to the first line
            # [ $line_no -gt 1 ] && printf '\033[%dA' (math $line_no - 1)

            # # redraw prompt with condensed grey strikethrough command
            # printf '\r%s\033[9;90m%s\033[m\033[K\n\033[K' \
            #    (fish_prompt) (__condense_commandline)

            # # clear the remaining lines
            # for line in (seq (count $cmd))
            #     printf '\033[K\n'
            # end

            # # move to last line
            # [ $line_no -lt $n_lines ] &&
            #     printf '\033[%dA\n' (math $n_lines - $line_no + 1)

            # # clear command line
            # commandline ""
        end
    end


    # custom hook called when enter is pressed
    function __on_press_enter
        commandline --is-valid
        if [ $status -eq 2 ]
            commandline -f execute
        else
            set cmd (commandline)
            if [ "$cmd" = "" ]
                echo
                commandline -f execute
            else

                # the two spaces "fixes" fish bug where autosuggestion
                # sticks around.
                # since trailing spaces are deleted, there will never
                # be a past command to autocomplete from
                set condensed (__condense_commandline)"  "

                commandline $condensed
                if [ $condensed = "" ]
                    printf "\n\n"
                    commandline -f repaint
                else
                    commandline -f execute
                end
            end
        end
    end


    # custom cd function to add 'cd -' and cdls functionality
    set -g __cd_last_dir (pwd)
    function cd
        set last_pwd (pwd)

        if [ "$argv[1]" = "-" ]
            builtin cd $__cd_last_dir
        else
            builtin cd $argv[1]
        end

        if [ (pwd) != $last_pwd ]
            set __cd_last_dir $last_pwd
            ls
        end
    end


    # newline after command except clear
    function __postexec_impl --on-event fish_postexec
        if [ (string trim $argv[1]) != clear ]
            echo
        end
    end


    function fcd
        set out "$HOME/.cache/fcd_dest_this_file_will_be_deleted"
        echo "" > $out
        command fcd "$HOME/.config/fcd/directories.txt" $out

        if [ -e $out ]
            set file (cat $out)
            set file (string replace "~" $HOME $file)
            set file (string replace '$HOME' $HOME $file)

            set cmd (commandline)
            if [ -e $file ]
                if [ $cmd = "" ]
                    if [ -d $file ]
                        commandline "cd $file  "
                        commandline -f execute
                    else
                        commandline "vim $file  "
                        commandline -f execute
                    end
                else
                    set cursor (commandline -C)
                    set chars (string split "" $cmd)
                    if [ $chars[$cursor] != " " ]
                        commandline -i " "$file
                    else
                        commandline -i $file
                    end
                end
            end
        end
    end


    # adds the functionality of bangbang (sudo !!, etc)
    function __bind_bang
        switch (commandline -t)[-1]
            case "!"
                commandline -t $history[1]; commandline -f repaint
            case "*"
                commandline -i !
        end
    end
    bind -M insert ! __bind_bang

    # use ls and switch to the directory after
    function lf
        set tmp (mktemp)
        command lf -last-dir-path=$tmp $argv

        if [ -f $tmp ]
            set dir (cat $tmp)
            rm -f $tmp >/dev/null
            [ -d $dir ] && [ $dir != (pwd) ] && cd $dir
        end
    end

    function mvcd
        mv $argv && cd $argv[-1]
    end

    function mkcd
        mkdir $argv[1] && cd $argv[1]
    end

    function jmatrix
        command jmatrix --bg "#1b1b20" --trail 12 $argv
    end

    # using /bin/ls since fish has its own ls which adds too much noise
    alias ls="/bin/ls --color=auto"
    alias ll="/bin/ls --color=auto -l"
    alias la="/bin/ls --color=auto -a"

    fish_vi_key_bindings
    set fish_cursor_default     block      blink
    set fish_cursor_insert      line       blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace     underscore blink
    set fish_cursor_visual      block

    bind -M insert                \cc __on_press_ctrl_c
    bind -M default     -m insert \cc __on_press_ctrl_c
    bind -M replace     -m insert \cc __on_press_ctrl_c
    bind -M replace_one -m insert \cc __on_press_ctrl_c

    bind -M insert                \r __on_press_enter
    bind -M default     -m insert \r __on_press_enter
    bind -M replace     -m insert \r __on_press_enter
    bind -M replace_one -m insert \r __on_press_enter

    # remove the buggy comment functionality
    bind -M replace '#' delete-char self-insert
    bind -M visual  '#' ''
    bind -M default '#' ''


    bind -M default zz  'zz && echo && echo && commandline -f repaint'
    bind -M insert  \cI 'commandline -f accept-autosuggestion'
    bind -M insert  \cN 'commandline -f complete'
    bind -M insert  \cF fcd
    bind -M default \cF fcd
end
