# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  fetchFromGitHub = (import <nixpkgs> {}).fetchFromGitHub;

  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;

  nixos-1803 = import (fetchFromGitHub {
    owner  = "nixos";
    repo   = "nixpkgs-channels";
    rev    = "138f2cc707d7ee13d93c86db3285460e244c402c";
    sha256 = "0h49j1cbnccqx996x80z7na9p7slnj9liz646s73s55am8wc9q8q";
  }) {};

  nixos-unstable = import (fetchFromGitHub {
    owner  = "nixos";
    repo   = "nixpkgs-channels";
    rev    = "19eedaf867da3155eec62721e0c8a02895aed74b";
    sha256 = "06k0hmdn8l1wiirfjcym86pn9rdi8xyfh1any6vgb5nbx87al515";
  }) {};

in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Ensure that filesystem is mounted at boot time as /
  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/nvme0n1p3";
      preLVM = true;
      allowDiscards = true;
    }
  ];

  # Automatically detect other OS installed and add them to the grub menu
  # boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball {
      config = config.nixpkgs.config;
    };
    xdotool-arximboldi = with pkgs; stdenv.mkDerivation rec {
      name = "xdotool-${version}";
      version = "git";
      src = fetchFromGitHub {
        owner = "arximboldi";
        repo = "xdotool";
        rev = "61ac3d0bad281e94a5d7b33316a72d48444aa60d";
        sha256 = "198944p7bndxbv41wrgjdkkrwnvddhk8dx6ldk0mad6c8p5gjdk1";
      };
      nativeBuildInputs = [ pkgconfig perl ];
      buildInputs = with xorg; [ libX11 libXtst xextproto libXi libXinerama libxkbcommon ];
      preBuild = ''
        mkdir -p $out/lib
     '';
      makeFlags = "PREFIX=$(out)";
      meta = {
        homepage = http://www.semicomplete.com/projects/xdotool/;
        description = "Fake keyboard/mouse input, window management, and more";
        license = pkgs.stdenv.lib.licenses.bsd3;
        maintainers = with stdenv.lib.maintainers; [viric];
        platforms = with stdenv.lib.platforms; linux;
      };
    };
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.bash.enableCompletion = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Libraries and development utilities documentation and manpages.
  documentation.dev.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [

    # Web
    chromium
    firefox
    google-chrome

    # Code
    vim
    zile
    emacs

    gnumake
    cmake
    gcc
    icu
    unstable.clang-tools
    gdb
    docker
    rustfmt
    gitAndTools.gitFull
    silver-searcher

    # Network
    wget
    networkmanager

    # Media
    smplayer
    calibre
    mplayer

    # Editors
    gimp-with-plugins
    gthumb
    inkscape
    libreoffice-fresh
    blender
    gcolor2

    # Utils
    manpages
    wget
    stow
    trash-cli
    htop
    lsof
    xorg.xkill
    ntfs3g
    openvpn

    # Work
    lastpass-cli
    bluejeans

    # Desktop
    numix-gtk-theme
    numix-cursor-theme
    numix-icon-theme
    numix-icon-theme-circle
    nixos-1803.taffybar
    dmenu
    ibus
    xdotool-arximboldi
    pa_applet
    pavucontrol
    blueman
    syncthing
    libnotify
    system-config-printer
    dunst
  ];

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      inconsolata
      ubuntu_font_family
      dejavu_fonts
      fira
      fira-mono
      fira-code
      fira-code-symbols
      source-sans-pro
      emojione
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # OpenVPN
  services.openvpn.servers = {
    s-cloud  = {
      config = '' config /home/maria/vpn/s-cloud/s-cloud.tblk/s-cloud.conf '';
      updateResolvConf = true;
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.hosts = {
    "163.172.181.40" = ["troy"];
    "127.0.0.1" = ["localhost"];
    "172.17.0.2" = ["docker"];
    # Work related
    "0.0.0.0" = ["checkout.soundcloud.test"];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    xkbOptions = "eurosign:e";

    # Enable touchpad support.
    libinput.enable = true;

    # Enable xmonad desktop envrionment
    # displayManager.gdm.enable = true;
    displayManager.lightdm.enable = true;

    # displayManager.sddm.enable = true;
    # desktopManager.plasma5.enable = true;
    desktopManager.gnome3.enable = true;
    desktopManager.xfce.enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      extraPackages = hs: [hs.taffybar];
    };
  };

  services.physlock = {
    enable = true;
    allowAnyUser = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.maria = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "users"
    ];
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
