#include "../include/block.hpp"

void NO_OP() {
}

Block::Block(const char *color, std::string contents) {
    this->contents = contents;
    this->color = color;
    this->onClick = NO_OP;
}
