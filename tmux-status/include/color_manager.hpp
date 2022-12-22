#include <stdio.h>

#define DEFAULT "default"
#define GREEN "green"
#define GREY "brightblack"
#define WHITE "white"
#define BLACK "black"

class ColorManager
{
public:
    void setFg(const char *color);
    void setBg(const char *color);
};
