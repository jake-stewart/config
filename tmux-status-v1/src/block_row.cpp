#include "../include/block_row.hpp"
#include "../include/color_manager.hpp"

ColorManager color_manager;

BlockRow::BlockRow(std::vector<Block*>& blocks) {
    m_blocks = blocks;
}

bool BlockRow::click(int pos) {
    int total = 0;
    for (Block *block : m_blocks) {
        if (pos >= total - 1 && pos <= total + block->contents.size() + 1) {
            block->onClick();
            return true;
        }
        total += block->contents.size() + 3;
    }
    return false;
}

int BlockRow::length() {
    int total = 0;
    for (int i = 0; i < m_blocks.size(); i++) {
        total += m_blocks[i]->contents.length();
        if (i < m_blocks.size() - 1) {
            total += 3;
        }
    }
    return total;
}

void BlockRow::clear() {
    m_blocks.clear();
}

void BlockRow::shorten(int target, bool from_back) {
    while (m_blocks.size() && length() > target) {
        if (from_back) {
            m_blocks.pop_back();
        }
        else {
            m_blocks.erase(m_blocks.begin());
        }
    }
}

void BlockRow::removeEmpty() {
    int offset = 0;
    for (int i = 0; i < m_blocks.size(); i++) {
        if (!m_blocks[i]->contents.length()) {
            offset++;
        }
        else {
            m_blocks[i - offset] = m_blocks[i];
        }
    }
    m_blocks.resize(m_blocks.size() - offset);
}

void BlockRow::print() {
    for (int i = 0; i < m_blocks.size(); i++) {
        color_manager.setFg(m_blocks[i]->color);
        printf("%s", m_blocks[i]->contents.c_str());

        if (i < m_blocks.size() - 1) {
            color_manager.setFg(GREY);
            printf(" | ");
        }
    }
}

int resize(BlockRow& left_row, BlockRow& right_row, int width) {
    int remaining = width - left_row.length();
    if (remaining <= 0) {
        right_row.clear();
        left_row.shorten(width, true);
        remaining = 0;
    }
    else {
        remaining -= right_row.length();
        if (remaining < 3) {
            right_row.shorten(width - left_row.length() - 3, false);
            remaining = width - left_row.length() - right_row.length();
        }
    }
    return remaining;
}
