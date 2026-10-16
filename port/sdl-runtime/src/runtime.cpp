#include "dreamshock/runtime.hpp"

#include <algorithm>
#include <cmath>
#include <iostream>
#include <system_error>

namespace dreamshock {
namespace {
constexpr Uint32 kWindowFlags = SDL_WINDOW_RESIZABLE | SDL_WINDOW_ALLOW_HIGHDPI;
constexpr double kFixedStep = 1.0 / static_cast<double>(kTargetFps);

bool isPressed(const Uint8* keys, SDL_Scancode code) {
    return keys[code] != 0;
}
} // namespace

AssetLocator::AssetLocator(std::filesystem::path root) {
    if (!root.empty()) {
        root_ = std::move(root);
    } else {
        std::error_code ec;
        root_ = std::filesystem::current_path(ec);
        if (ec) {
            root_ = ".";
        }
    }
    root_ = root_.lexically_normal();
}

std::filesystem::path AssetLocator::resolve(const std::filesystem::path& relative) const {
    if (relative.is_absolute()) {
        return relative.lexically_normal();
    }
    return (root_ / relative).lexically_normal();
}

InputSystem::~InputSystem() {
    shutdown();
}

void InputSystem::shutdown() {
    if (controller_ != nullptr) {
        SDL_GameControllerClose(controller_);
        controller_ = nullptr;
    }
    controllerInstance_ = -1;
    knownControllers_.clear();
}

bool InputSystem::initialize(std::string& error) {
    if (SDL_InitSubSystem(SDL_INIT_GAMECONTROLLER | SDL_INIT_JOYSTICK) != 0) {
        error = SDL_GetError();
        return false;
    }

    SDL_GameControllerEventState(SDL_ENABLE);
    const int count = SDL_NumJoysticks();
    for (int i = 0; i < count; ++i) {
        if (SDL_IsGameController(i) == SDL_TRUE) {
            openController(i);
            if (controller_ != nullptr) {
                break;
            }
        }
    }
    return true;
}

void InputSystem::openController(int deviceIndex) {
    if (controller_ != nullptr || SDL_IsGameController(deviceIndex) != SDL_TRUE) {
        return;
    }
    controller_ = SDL_GameControllerOpen(deviceIndex);
    if (controller_ != nullptr) {
        SDL_Joystick* joystick = SDL_GameControllerGetJoystick(controller_);
        controllerInstance_ = SDL_JoystickInstanceID(joystick);
        knownControllers_.push_back(controllerInstance_);
        std::cout << "Gamepad connected: "
                  << SDL_GameControllerName(controller_) << '\n';
    }
}

void InputSystem::closeController(SDL_JoystickID instanceId) {
    if (controller_ != nullptr && controllerInstance_ == instanceId) {
        SDL_GameControllerClose(controller_);
        controller_ = nullptr;
        controllerInstance_ = -1;
    }
    knownControllers_.erase(
        std::remove(knownControllers_.begin(), knownControllers_.end(), instanceId),
        knownControllers_.end());
}

void InputSystem::processEvent(const SDL_Event& event) {
    if (event.type == SDL_QUIT) {
        quitRequested_ = true;
    } else if (event.type == SDL_CONTROLLERDEVICEADDED) {
        openController(event.cdevice.which);
    } else if (event.type == SDL_CONTROLLERDEVICEREMOVED) {
        closeController(event.cdevice.which);
    }
}

InputState InputSystem::state() const noexcept {
    InputState result;
    result.quitRequested = quitRequested_;

    const Uint8* keys = SDL_GetKeyboardState(nullptr);
    result.left = isPressed(keys, SDL_SCANCODE_LEFT) || isPressed(keys, SDL_SCANCODE_A);
    result.right = isPressed(keys, SDL_SCANCODE_RIGHT) || isPressed(keys, SDL_SCANCODE_D);
    result.up = isPressed(keys, SDL_SCANCODE_UP) || isPressed(keys, SDL_SCANCODE_W);
    result.down = isPressed(keys, SDL_SCANCODE_DOWN) || isPressed(keys, SDL_SCANCODE_S);
    result.jump = isPressed(keys, SDL_SCANCODE_SPACE) || isPressed(keys, SDL_SCANCODE_X);
    result.attack = isPressed(keys, SDL_SCANCODE_Z) || isPressed(keys, SDL_SCANCODE_J);
    result.dash = isPressed(keys, SDL_SCANCODE_C) || isPressed(keys, SDL_SCANCODE_K);
    result.pause = isPressed(keys, SDL_SCANCODE_ESCAPE) || isPressed(keys, SDL_SCANCODE_RETURN);
    result.confirm = isPressed(keys, SDL_SCANCODE_RETURN) || isPressed(keys, SDL_SCANCODE_Z);
    result.cancel = isPressed(keys, SDL_SCANCODE_ESCAPE) || isPressed(keys, SDL_SCANCODE_X);

    if (controller_ != nullptr && SDL_GameControllerGetAttached(controller_) == SDL_TRUE) {
        result.left = result.left || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_DPAD_LEFT);
        result.right = result.right || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_DPAD_RIGHT);
        result.up = result.up || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_DPAD_UP);
        result.down = result.down || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_DPAD_DOWN);
        result.jump = result.jump || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_A);
        result.attack = result.attack || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_X);
        result.dash = result.dash || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_B);
        result.pause = result.pause || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_START);
        result.confirm = result.confirm || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_A);
        result.cancel = result.cancel || SDL_GameControllerGetButton(controller_, SDL_CONTROLLER_BUTTON_B);
    }

    return result;
}

AudioSystem::~AudioSystem() {
    shutdown();
}

bool AudioSystem::initialize(std::string& error) {
    if ((SDL_WasInit(SDL_INIT_AUDIO) & SDL_INIT_AUDIO) == 0) {
        if (SDL_InitSubSystem(SDL_INIT_AUDIO) != 0) {
            error = SDL_GetError();
            return false;
        }
    }

    constexpr int frequency = 44100;
    constexpr Uint16 format = AUDIO_S16SYS;
    constexpr int channels = 2;
    constexpr int chunkSize = 1024;
    if (Mix_OpenAudio(frequency, format, channels, chunkSize) != 0) {
        error = Mix_GetError();
        return false;
    }

    Mix_AllocateChannels(16);
    initialized_ = true;
    return true;
}

bool AudioSystem::playMusic(const std::filesystem::path& path, int loops) {
    if (!initialized_) {
        return false;
    }
    Mix_Music* next = Mix_LoadMUS(path.string().c_str());
    if (next == nullptr) {
        std::cerr << "Audio: unable to load music '" << path.string()
                  << "': " << Mix_GetError() << '\n';
        return false;
    }

    Mix_HaltMusic();
    if (music_ != nullptr) {
        Mix_FreeMusic(music_);
    }
    music_ = next;
    if (Mix_PlayMusic(music_, loops) != 0) {
        std::cerr << "Audio: unable to play music: " << Mix_GetError() << '\n';
        return false;
    }
    return true;
}

bool AudioSystem::playSound(const std::filesystem::path& path, int channel) {
    if (!initialized_) {
        return false;
    }
    Mix_Chunk* sound = Mix_LoadWAV(path.string().c_str());
    if (sound == nullptr) {
        std::cerr << "Audio: unable to load sound '" << path.string()
                  << "': " << Mix_GetError() << '\n';
        return false;
    }
    sounds_.push_back(sound);
    if (Mix_PlayChannel(channel, sound, 0) == -1) {
        std::cerr << "Audio: unable to play sound: " << Mix_GetError() << '\n';
        return false;
    }
    return true;
}

void AudioSystem::stopMusic() {
    if (initialized_) {
        Mix_HaltMusic();
    }
}

void AudioSystem::shutdown() {
    if (initialized_) {
        Mix_HaltMusic();
        Mix_HaltChannel(-1);
    }
    for (Mix_Chunk* sound : sounds_) {
        Mix_FreeChunk(sound);
    }
    sounds_.clear();
    if (music_ != nullptr) {
        Mix_FreeMusic(music_);
        music_ = nullptr;
    }
    if (initialized_) {
        Mix_CloseAudio();
        initialized_ = false;
    }
}

Runtime::~Runtime() {
    shutdown();
}

bool Runtime::initialize(std::string& error) {
    if (SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_TIMER | SDL_INIT_GAMECONTROLLER) != 0) {
        error = SDL_GetError();
        return false;
    }

    window_ = SDL_CreateWindow(
        "DreamShock — SDL Runtime",
        SDL_WINDOWPOS_CENTERED,
        SDL_WINDOWPOS_CENTERED,
        kLogicalWidth * 3,
        kLogicalHeight * 3,
        kWindowFlags);
    if (window_ == nullptr) {
        error = SDL_GetError();
        shutdown();
        return false;
    }

    renderer_ = SDL_CreateRenderer(
        window_, -1, SDL_RENDERER_ACCELERATED | SDL_RENDERER_PRESENTVSYNC);
    if (renderer_ == nullptr) {
        renderer_ = SDL_CreateRenderer(window_, -1, SDL_RENDERER_SOFTWARE);
    }
    if (renderer_ == nullptr) {
        error = SDL_GetError();
        shutdown();
        return false;
    }

    SDL_RenderSetLogicalSize(renderer_, kLogicalWidth, kLogicalHeight);
    SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "0");

    if (!input_.initialize(error)) {
        shutdown();
        return false;
    }
    if (!audio_.initialize(error)) {
        // Audio is optional for the initial boot smoke test; continue with a warning.
        std::cerr << "Audio subsystem unavailable: " << error << '\n';
        error.clear();
    }

    assets_ = AssetLocator(std::filesystem::current_path());
    initialized_ = true;
    running_ = true;
    lastCounter_ = SDL_GetPerformanceCounter();

    std::cout << "DreamShock SDL runtime initialized (" << kLogicalWidth
              << "x" << kLogicalHeight << " logical resolution).\n";
    std::cout << "Asset root: " << assets_.root().string() << '\n';
    return true;
}

int Runtime::run() {
    if (!initialized_) {
        return 1;
    }

    while (running_) {
        SDL_Event event;
        while (SDL_PollEvent(&event) != 0) {
            handleEvent(event);
        }

        const Uint64 now = SDL_GetPerformanceCounter();
        const double elapsed = static_cast<double>(now - lastCounter_) /
                               static_cast<double>(SDL_GetPerformanceFrequency());
        lastCounter_ = now;
        accumulator_ += std::min(elapsed, 0.25);

        while (accumulator_ >= kFixedStep) {
            update(kFixedStep);
            accumulator_ -= kFixedStep;
        }
        render();

        // Avoid spinning if vsync is not available on the selected renderer.
        if (elapsed < 0.001) {
            SDL_Delay(1);
        }
    }
    return 0;
}

void Runtime::handleEvent(const SDL_Event& event) {
    input_.processEvent(event);
    if (event.type == SDL_WINDOWEVENT &&
        event.window.event == SDL_WINDOWEVENT_CLOSE) {
        running_ = false;
    }
}

void Runtime::update(double deltaSeconds) {
    (void)deltaSeconds;
    if (input_.state().quitRequested) {
        running_ = false;
    }
}

void Runtime::render() {
    if (renderer_ == nullptr) {
        return;
    }
    SDL_SetRenderDrawColor(renderer_, 10, 12, 22, 255);
    SDL_RenderClear(renderer_);

    // Diagnostic frame: verifies logical scaling and renderer initialization.
    SDL_SetRenderDrawColor(renderer_, 40, 45, 66, 255);
    SDL_Rect innerFrame{8, 8, kLogicalWidth - 16, kLogicalHeight - 16};
    SDL_RenderDrawRect(renderer_, &innerFrame);

    SDL_SetRenderDrawColor(renderer_, 110, 180, 255, 255);
    SDL_Rect marker{static_cast<int>(kLogicalWidth / 2) - 3,
                    static_cast<int>(kLogicalHeight / 2) - 3, 6, 6};
    SDL_RenderFillRect(renderer_, &marker);

    SDL_RenderPresent(renderer_);
}

void Runtime::shutdown() {
    running_ = false;
    audio_.shutdown();
    input_.shutdown();
    if (renderer_ != nullptr) {
        SDL_DestroyRenderer(renderer_);
        renderer_ = nullptr;
    }
    if (window_ != nullptr) {
        SDL_DestroyWindow(window_);
        window_ = nullptr;
    }
    if (SDL_WasInit(0) != 0) {
        SDL_Quit();
    }
    initialized_ = false;
}

} // namespace dreamshock
