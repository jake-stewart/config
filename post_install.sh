# this file executes once the configs are applied
# this is useful for chmod +x on scripts for example

FILES_NEED_EXECUTABLE="\
$HOME/.config/tmux/statusline.sh
$HOME/.config/fish/smart_join.py"

for file in $FILES_NEED_EXECUTABLE; do
    if [ -f "$file" ]; then
        chmod +x "$file"
    fi
done
