#include "dreamshock/runtime.hpp"

#include <iostream>

int main(int, char**) {
    dreamshock::Runtime runtime;
    std::string error;

    if (!runtime.initialize(error)) {
        std::cerr << "DreamShock SDL startup failed: " << error << '\n';
        return 1;
    }

    const int result = runtime.run();
    runtime.shutdown();
    return result;
}
