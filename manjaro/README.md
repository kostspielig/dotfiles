# Manjaro setup

## Basic setup

Update mirror list and sort it by speed, otherwise you will get timeouts

```
sudo pacman-mirrors --fasttrack
sudo pacman -Syu
```

TRIM allows an operating system to inform a solid-state drive (SSD) which blocks of data are no longer considered to be 'in use' and therefore can be erased internally.

```
sudo systemctl enable fstrim.timer
```

Install wayland(alternative display server to Xorg) and sway (tiling window manager, alternative to i3/xmonad)

```
sudo pacman -S xorg-xwayland
sudo pacman -S sway
# Programs needed by sway default config
sudo pacman -S swaylock swayidle dmenu alacritty
```

Start personalizing your sway config

```
mkdir .config/sway
cp /etc/sway/config ~/.config/sway/config
```


## Advanced setup

Install additional needed packages

`sudo pacman -S i3status ttf-inconsolata noto-fonts-emoji mako grim slurp kitty brightnessctl`

* i3status: program that generates status bar with wifi/battery/time/... (configuration in sway/.i3status.conf)
* mako: custom notifications (configuration in sway/.config/mako/config)
* grim/slurp: Screenshot utilities
* kitty: terminal (configuration in kitty/kitty.conf)
* brightnessctl: utility used to control device brightness


Installing nodejs through NVM as a version manager (you can use npm without sudo out of the box)

`sudo pacman -S nvm`

Install latest version of node

`nvm install node`

Install spotify

`sudo snap install spotify`


## How to with command line

### Wifi

Command line: `nmtui`

### Bluetooth

GUI interface: `blueman-manager`

### Sound

GUI interface `pavucontrol` or command line `alsamixer`

### File managers

`thunar` or `engrampa`
