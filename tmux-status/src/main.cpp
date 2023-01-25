#include <string>
#include <vector>
#include <filesystem>

#include "../include/color_manager.hpp"
#include "../include/block_row.hpp"
#include "../include/util.hpp"

using std::string;
namespace fs = std::filesystem;

string pane_title;
fs::path pane_path;
string window_str;
int window_idx;
string session_title;
int client_width;
bool is_zoomed;
int mouse_x;
const char *color = GREEN;

string getProjectDetails(string& session_name, fs::path& pane_path) {
    const string sed = "sed 's+^refs/heads/+:+'";
    const string git = "git symbolic-ref HEAD 2>/dev/null";
    const string cmd
        = "(cd '" + pane_path.string() + "' && " + git + " | " + sed + ")";

    return session_name + execGetline(cmd);
}

std::vector<Block*> createTabBlocks(int active_idx, string& window_str) {
    std::vector<Block*> blocks;

    int len = window_str.size();
    int idx = 0;
    int start = 0;
    int end = 0;
    while (start < len) {
        do {
            end++;
        }
        while (end < len && window_str[end] != ',');

        if (start != end) {
            Block *block = new Block(
                idx == active_idx ? color : DEFAULT,
                window_str.substr(start, end - start)
            );
            block->onClick = [idx]() {
                system(string(("tmux select-window -t ") + std::to_string(idx)).c_str());
            };
            blocks.push_back(block);
            start = ++end;
        }
        idx++;
    }

    return blocks;
}

BlockRow createLeftRow() {
    std::vector<Block*> left_blocks = createTabBlocks(window_idx, window_str);
    BlockRow left_row(left_blocks);
    left_row.removeEmpty();
    return left_row;
}

BlockRow createRightRow() {
    Block *paneTitleBlock = new Block(DEFAULT, pane_title);
    Block *paneCwdBlock   = new Block(DEFAULT, pane_path.filename());
    Block *projectBlock   = new Block(color, getProjectDetails(session_title, pane_path));
    Block *dateBlock      = new Block(DEFAULT, getTime("%H:%M %d-%b-%y"));

    projectBlock->onClick = [] () {
        system("~/.config/tmux/popup-switch-session.sh");
    };

    std::vector<Block*> right_blocks = {
        paneTitleBlock,
        paneCwdBlock,
        projectBlock,
        dateBlock,
    };

    BlockRow right_row(right_blocks);
    right_row.removeEmpty();

    return right_row;
}


int main(int argc, const char **argv) {
    pane_title    = argv[1];
    pane_path     = argv[2];
    window_str    = argv[3];
    window_idx    = std::stoi(argv[4]);
    session_title = argv[5];
    client_width  = std::stoi(argv[6]);
    is_zoomed     = std::stoi(argv[7]);
    mouse_x       = std::stoi(argv[8]);

    ColorManager color_manager;
    if (is_zoomed) {
        color_manager.setBg("#323644");
    }

    if (session_title == "main") {
        color = "cyan";
    }
    else {
        std::string colorEnv = execGetline(
            "tmux show-environment session_color | sed 's/.*=//'"
        );

        if (colorEnv.size()) {
            color = colorEnv.c_str();
        }
        else {
            color = "brightblack";
        }
    }

    int padding_l = 1;
    int padding_r = 1;

    BlockRow left_row = createLeftRow();
    BlockRow right_row = createRightRow();

    int remaining = resize(left_row, right_row, client_width - padding_l - padding_r);

    if (mouse_x >= 0) {
        if (!left_row.click(mouse_x - padding_l)) {
            right_row.click(mouse_x - (client_width - right_row.length() - padding_r));
        }
        return 0;
    }

    for (int i = 0; i < padding_l; i++) {
        printf(" ");
    }

    left_row.print();
    printf("%*s", remaining, "");
    right_row.print();

    return 0;
}
