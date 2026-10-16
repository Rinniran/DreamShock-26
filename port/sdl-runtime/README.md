# DreamShock SDL Runtime — Step 1

This is the first C++ runtime foundation for porting DreamShock out of Godot. It is intentionally isolated under `port/sdl-runtime/`; it does not alter the original Godot project or its startup scene.

## Current scope

- C++20 and CMake project
- SDL2 window, renderer, event loop, and fixed 60 Hz update step
- 427 × 240 logical render resolution (matching the current Godot project settings)
- Keyboard and SDL GameController input abstraction
- SDL_mixer audio initialization and music / sound-effect helpers
- Asset path resolver
- Diagnostic frame to verify startup and logical scaling

This is infrastructure, not a playable port yet. It does not load Godot scenes, import Godot resources, or implement the original player controller.

## Dependencies

Install a C++20 compiler, CMake 3.21+, SDL2 development files, and SDL2_mixer development files. The CMake configuration expects packages exporting `SDL2::SDL2` and `SDL2_mixer::SDL2_mixer` targets (for example, packages installed through vcpkg).

### Windows with vcpkg

From a Developer PowerShell with vcpkg available:

```powershell
vcpkg install sdl2 sdl2-mixer
cmake -S port/sdl-runtime -B build/sdl-runtime -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
cmake --build build/sdl-runtime --config Release
.uildsdl-runtimeindreamshock_sdl.exe
```

Depending on your generator and vcpkg triplet, the executable may be placed under a configuration subdirectory such as `bin/Release`.

### Linux (package names vary by distribution)

Install SDL2, SDL2_mixer, CMake, and a C++ compiler using your distribution's package manager, then configure and build:

```sh
cmake -S port/sdl-runtime -B build/sdl-runtime
cmake --build build/sdl-runtime --parallel
./build/sdl-runtime/bin/dreamshock_sdl
```

If your distribution provides SDL packages without CMake config files, install the development packages that expose CMake package targets or adapt the CMake dependency discovery to use pkg-config.

## Smoke test

1. Configure and compile successfully.
2. Launch the executable; a resizable window should appear with a dark background, border, and small blue center marker.
3. Resize the window and verify the 427 × 240 logical image remains scaled.
4. Connect an SDL-compatible controller before launch and verify startup logs its name. Keyboard/controller state is available through `InputSystem::state()`.
5. Close the window and verify the process exits cleanly.

## Input defaults

| Action | Keyboard | SDL GameController |
|---|---|---|
| Move | Arrow keys / WASD | D-pad |
| Jump | Space / X | A |
| Attack | Z / J | X |
| Dash | C / K | B |
| Pause | Escape / Enter | Start |

These are temporary SDL defaults. The original project's `PAD1_*` actions and configurable remapping will be reconciled in a later step.

## Next

The next milestone should add an asset manifest and resource cache, then build the first sprite/texture loading path before porting gameplay and stage scenes.
