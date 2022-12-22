#include <string>

struct Block
{
    const char *color;
    std::string contents;
    std::function<void (void)> onClick;

    Block(const char *color, std::string contents);
};

