# this file executes once the configs are applied
# this is useful for chmod +x on scripts for example


if [ -f "$HOME/.config/tmux/statusline.sh" ]; then
    chmod +x "$HOME/.config/tmux/statusline.sh"
fi
