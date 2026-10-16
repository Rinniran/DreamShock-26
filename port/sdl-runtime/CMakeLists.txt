cmake_minimum_required(VERSION 3.21)
project(DreamShockSDLRuntime VERSION 0.1.0 LANGUAGES CXX)

option(DREAMSHOCK_WARNINGS_AS_ERRORS "Treat compiler warnings as errors" OFF)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(SDL2 CONFIG REQUIRED)
find_package(SDL2_mixer CONFIG REQUIRED)

add_executable(dreamshock_sdl
    src/main.cpp
    src/runtime.cpp
)

target_include_directories(dreamshock_sdl PRIVATE include)
target_link_libraries(dreamshock_sdl PRIVATE SDL2::SDL2 SDL2_mixer::SDL2_mixer)

if(TARGET SDL2::SDL2main)
    target_link_libraries(dreamshock_sdl PRIVATE SDL2::SDL2main)
endif()

if(MSVC)
    target_compile_options(dreamshock_sdl PRIVATE /W4)
    if(DREAMSHOCK_WARNINGS_AS_ERRORS)
        target_compile_options(dreamshock_sdl PRIVATE /WX)
    endif()
else()
    target_compile_options(dreamshock_sdl PRIVATE -Wall -Wextra -Wpedantic)
    if(DREAMSHOCK_WARNINGS_AS_ERRORS)
        target_compile_options(dreamshock_sdl PRIVATE -Werror)
    endif()
endif()

# Run from this directory by default so relative assets resolve consistently.
set_target_properties(dreamshock_sdl PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)
