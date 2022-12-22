#include "../include/color_manager.hpp"

const char *current_fg = DEFAULT;
const char *current_bg = DEFAULT;

void ColorManager::setFg(const char *color) {
    if (color != current_fg) {
        current_fg = color;
        printf("#[fg=%s]", color);
    }
}

void ColorManager::setBg(const char *color) {
    if (color != current_bg) {
        current_bg = color;
        printf("#[bg=%s]", color);
    }
}
