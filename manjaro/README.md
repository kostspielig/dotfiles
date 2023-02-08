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

Install other programs in flatpak:

`flatpak install net.sourceforge.xournal`
`flatpak install org.blender.Blender`

Run the program: `flatpak run org.blender.Blender`

## How to with command line

### Wifi

Command line: `nmtui`
Alternatively, you can install nm-applet with:
`yay -S network-manager-applet`

Add the applet to the sway tray by addint to your sway config:
`exec nm-applet --indicator`

Or execute the interface by:
 `nm-connection-editor`

Use command line `nmcli`
List networks using `nmcli c`
Connect to a network: `nmcli con up ssid/uuid`

### WhoIsHome
`sudo arp-scan --interface=wlp2s0 --localnet -l`

### Bluetooth

GUI interface: `blueman-manager`

### Sound

GUI interface `pavucontrol` or command line `alsamixer`

### File managers

`thunar` or `engrampa`

### Window properties

Use the comand `xprop` (plus click on the desired window) to get X window properties (including WM_CLASS)


### Upgrade system

`sudo pacman -Syyu`

* -S: synchronize your system’s packages with those in the official repo
* -y: download fresh package databases from the server
* -u: upgrade all installed packages

update chrome `yay -Syu google-chrome`

### Remove cache files

`sudo pacman -Scc`

### Uninstall packages
`sudo pacman -Rns #package_name#`

## Troubleshooting

#### Display manager

After a while my display manager refused to log into sway, showing a black screen with a blinking cursor and then restarting lightdm (the display manager used by default).

Switch to tty with `Ctr+Alt+F5` and login. Then start sway with `sway` command.

### Reload sway config

If you change sway or i3status config, you can reload by `Shift+Mod+C`
