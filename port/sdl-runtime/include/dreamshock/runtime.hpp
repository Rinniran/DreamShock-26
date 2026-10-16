#pragma once

#include <SDL.h>
#include <SDL_mixer.h>

#include <filesystem>
#include <string>
#include <vector>

namespace dreamshock {

inline constexpr int kLogicalWidth = 427;
inline constexpr int kLogicalHeight = 240;
inline constexpr int kTargetFps = 60;

class AssetLocator {
public:
    explicit AssetLocator(std::filesystem::path root = {});
    [[nodiscard]] std::filesystem::path resolve(const std::filesystem::path& relative) const;
    [[nodiscard]] const std::filesystem::path& root() const noexcept { return root_; }

private:
    std::filesystem::path root_;
};

struct InputState {
    bool left = false;
    bool right = false;
    bool up = false;
    bool down = false;
    bool jump = false;
    bool attack = false;
    bool dash = false;
    bool pause = false;
    bool confirm = false;
    bool cancel = false;
    bool quitRequested = false;
};

class InputSystem {
public:
    InputSystem() = default;
    ~InputSystem();

    bool initialize(std::string& error);
    void processEvent(const SDL_Event& event);
    void shutdown();
    [[nodiscard]] InputState state() const noexcept;

private:
    void openController(int deviceIndex);
    void closeController(SDL_JoystickID instanceId);

    SDL_GameController* controller_ = nullptr;
    SDL_JoystickID controllerInstance_ = -1;
    std::vector<SDL_JoystickID> knownControllers_;
    bool quitRequested_ = false;
};

class AudioSystem {
public:
    AudioSystem() = default;
    ~AudioSystem();

    bool initialize(std::string& error);
    bool playMusic(const std::filesystem::path& path, int loops = -1);
    bool playSound(const std::filesystem::path& path, int channel = -1);
    void stopMusic();
    void shutdown();

private:
    bool initialized_ = false;
    Mix_Music* music_ = nullptr;
    std::vector<Mix_Chunk*> sounds_;
};

class Runtime {
public:
    Runtime() = default;
    ~Runtime();

    bool initialize(std::string& error);
    int run();
    void shutdown();

private:
    void handleEvent(const SDL_Event& event);
    void update(double deltaSeconds);
    void render();

    SDL_Window* window_ = nullptr;
    SDL_Renderer* renderer_ = nullptr;
    InputSystem input_;
    AudioSystem audio_;
    AssetLocator assets_;
    bool initialized_ = false;
    bool running_ = false;
    Uint64 lastCounter_ = 0;
    double accumulator_ = 0.0;
};

} // namespace dreamshock
