#include "../include/util.hpp"
#include <cstring>

std::string execGetline(std::string cmd) {
    char buffer[128];
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)>
        pipe(popen(cmd.c_str(), "r"), pclose);
    if (pipe && fgets(buffer, sizeof(buffer), pipe.get())) {
        buffer[strcspn(buffer, "\n")] = 0;
        result = buffer;
    }
    return result;
}

std::string getTime(const char *fmt) {
    time_t rawtime;
    struct tm * timeinfo;
    char buffer[80];
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    strftime(buffer, sizeof(buffer), fmt, timeinfo);
    return buffer;
}
