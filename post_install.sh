# this file executes once the configs are applied
# this is useful for chmod +x on scripts for example


if [ -f "$HOME/.config/tmux/statusline.sh" ]; then
    chmod +x "$HOME/.config/tmux/statusline.sh"
fi

if [ -f "$HOME/.config/fish/smart_join.py" ]; then
    chmod +x "$HOME/.config/fish/smart_join.py"
fi
