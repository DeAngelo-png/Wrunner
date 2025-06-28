<pre align=center>  _      __                          
 | | /| / /_____ _____  ___  ___ ____
 | |/ |/ / __/ // / _ \/ _ \/ -_) __/
 |__/|__/_/  \_,_/_//_/_//_/\__/_/   
                                     </pre>
<p align=center>
wrunner is a flexible bash script to run videos as dynamic wallpapers on Linux. It supports multi-monitor setups (only tested with dual monitors), thumbnail generation, blurring, and smart wallpaper behavior designed especially for i3 and other lightweight window managers like hyprland and such.

---

## Features

- Loop videos as wallpapers using `xwinwrap` + `mpv`
- Generate and set thumbnails via `ffmpeg` and `feh`
- Optional blur on thumbnails using `ImageMagick`
- Intelligent pause/resume logic based on window focus
- Multi-monitor support via `xrandr`
- Fully scriptable with CLI flags
- Custom thumbnail storage path

---

## Installation

Use the included `install.sh` script to install required dependencies across common Linux distributions:

```bash
chmod +x install.sh
./install.sh
````

> 🛈 **Note:** `xwinwrap` may not be in official repos on all distros. You may need to [build it from source](https://github.com/ujjwal96/xwinwrap).

Make the main script executable:

```bash
chmod +x setup.sh
```

---

## Usage

```bash
./setup.sh [OPTIONS] [VIDEO,BLUR_GEOMETRY,TIME_STAMP]...
```

### Options

| Flag | Description                                                                                      |
| ---- | ------------------------------------------------------------------------------------------------ |
| `-a` | Always run the video wallpaper (do not pause when i3 is focused)                                 |
| `-n` | Generate thumbnails using `ffmpeg`                                                               |
| `-w` | Set generated thumbnail as wallpaper with `feh`                                                  |
| `-b` | Blur the thumbnail (requires `ImageMagick`)                                                      |
| `-f` | Wallpaper fit mode for `feh` — one of `center`, `fill`, `max`, `scale`, `tile` (default: `fill`) |
| `-d` | Path to store thumbnails (default: `$HOME/Pictures/i3-video-wallpaper`)                          |
| `-h` | Show help message                                                                                |

---

## Dependencies

* `xwinwrap`
* `mpv`
* `ffmpeg`
* `feh`
* `imagemagick`
* `xdotool`
* `socat`

---

## Example

```bash
./setup.sh -anwb path/to/video.mp4,32x32,00:00:01 path/to/second.mp4
```

This will:

* Always run the video wallpaper
* Generate thumbnails at `00:00:01`
* Blur them using `32x32` geometry
* Set the thumbnails as wallpapers with `feh`

---

## Advanced Behavior

* Automatically detects all connected monitors using `xrandr`
* Keeps track of `xwinwrap` PIDs for clean restarts
* Pauses video playback when i3 is focused (unless `-a` is used)
* Uses IPC via `socat` to control `mpv` processes

---

## File Structure

```
.
├── install.sh     # Installs dependencies based on detected distro
├── setup.sh       # Main script to launch wrunner
└── README.md      # You're reading it :)
```

---

## Building `xwinwrap` (if not in repos)

If `xwinwrap` is not available for your distribution:

```bash
git clone https://github.com/ujjwal96/xwinwrap.git
cd xwinwrap
make
sudo make install
```

---
![Platform: Linux](https://img.shields.io/badge/platform-linux-lightgrey)
![Shell: Bash](https://img.shields.io/badge/shell-bash-blue)
![Window Manager: i3](https://img.shields.io/badge/i3wm-supported-brightgreen)
