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
  boot.initrd.luks.devices =
    {
      root = {
        device = "/dev/nvme0n1p3";
        preLVM = true;
        allowDiscards = true;
      };
    };

  # Automatically detect other OS installed and add them to the grub menu
  # boot.loader.grub.useOSProber = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.virtualbox.host.enable = true;

  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.packageOverrides = pkgs: {
    unstable = import unstableTarball {
      config = config.nixpkgs.config;
    };
    xdotool-arximboldi = with pkgs; xdotool.overrideDerivation (attrs: rec {
      name = "xdotool-${version}";
      version = "git";
      src = fetchFromGitHub {
        owner = "arximboldi";
        repo = "xdotool";
        rev = "61ac3d0bad281e94a5d7b33316a72d48444aa60d";
        sha256 = "198944p7bndxbv41wrgjdkkrwnvddhk8dx6ldk0mad6c8p5gjdk1";
      };
    });
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  programs.bash.enableCompletion = true;

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    consoleFont = "Lat2-Terminus16";
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
    unstable.firefox
    google-chrome # Fails fetchurl hash algorithm when unstable
    unstable.slack
    unstable.metals

    # Code
    vim
    zile
    emacs
    jetbrains.idea-community

    gnumake
    cmake
    ruby
    gcc
    nodejs-10_x # emacs tide-mode
    sbt # emacs for scala-mode
    coursier # metals-emacs (scala)
    icu
    unstable.clang-tools
    gdb
    docker
    docker-machine # sc-tools
    virtualbox # sc-tools: docker-machine
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
    jq
    xautolock

    # Work
    dbeaver

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

  # Needed for payments-buckster
  services.mysql.enable = true;
  services.mysql.package = pkgs.mysql;
  # services.mysql.dataDir = "/var/db";

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

  security.pki.certificates = [ ''
    SoundCloud v2 local
    ===================
    -----BEGIN CERTIFICATE-----
    MIID3DCCAsSgAwIBAgIHAVRoYTYkIDANBgkqhkiG9w0BAQsFADBmMRswGQYDVQQD
    ExJ2Mi5zb3VuZGNsb3VkLnRlc3QxCzAJBgNVBAYTAkRFMQ0wCwYDVQQIEwRURVNU
    MQ0wCwYDVQQHEwRURVNUMQ0wCwYDVQQKEwRURVNUMQ0wCwYDVQQLEwRURVNUMB4X
    DTE5MDEwNzEwNDI0MVoXDTIwMDExNTAwMDAwMFowZjEbMBkGA1UEAxMSdjIuc291
    bmRjbG91ZC50ZXN0MQswCQYDVQQGEwJERTENMAsGA1UECBMEVEVTVDENMAsGA1UE
    BxMEVEVTVDENMAsGA1UEChMEVEVTVDENMAsGA1UECxMEVEVTVDCCASIwDQYJKoZI
    hvcNAQEBBQADggEPADCCAQoCggEBAJihL+/nAimB3UoS15n0xK96Ywtbul3vnxRI
    waM/e4LZGiTxd9X5UNgABFGyNz9CfoiBEXiLdiA6FQXG8Gv7dON89r07dbeDNsB5
    iph+++vej68katPk8M465iJ8VZB4vbdvqyKUinVbSa9i+bIz/e6sb2RngphEam1h
    KHMM/1IkDM1q4Jzhjt9NXuFpv/WaMxUp9dE2U7/RMloSJ1lZRVSvo5+G9lr4lPNd
    alaIoEuLNfJOdIJXqdVg0f2jB6zzL3ppcrvRFdDNf2tS/BEHuB/Ubt3AHKLls4Mm
    34ENKENMunu42dSY8S2oYQMDfnkaaDOeA/bXi0rzhMcBv6s/RtECAwEAAaOBjjCB
    izAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIC9DAdBgNVHSUEFjAUBggrBgEFBQcD
    AQYIKwYBBQUHAwgwEQYJYIZIAYb4QgEBBAQDAgD1MB0GA1UdDgQWBBSkNoV3mmkO
    dLUtXxCfhwgSM0IZGzAdBgNVHREEFjAUghJ2Mi5zb3VuZGNsb3VkLnRlc3QwDQYJ
    KoZIhvcNAQELBQADggEBAD/uwljOBj8e5iwGOAXT136nGbbLwHelYlINpm0ST+bT
    U9ewfztxfZUnkGXNg7ZwzTeKEMJ9p/iPIAHkiWGMDBiVVttwC7mxAatQEkIoI8pu
    DIcgFZ61vg+QV2tiEyJT9P2dlnwWANV70GgpZPUwHetMSvIe9bCGBVyvkYb2OpLa
    qvUnq7/9W4Hwoh2+M2qJbC4uEe379KQXaAkO8hCTZV01p24GUwf6ZctKrN29UdYT
    gi29srQ4yIrmkvzv8sKchhTjqt/qHNcPJxWiosq29dRYTNlBPILXhmJ+8GT9rnP0
    genbI9KcMdNFtytJFxSVwNqAuOmVal3p69Q+l21A0l8=
    -----END CERTIFICATE-----
  ''
  ''
    SoundCloud a2 local
    ===================
    -----BEGIN CERTIFICATE-----
    MIID3DCCAsSgAwIBAgIHAVRoYVWAlTANBgkqhkiG9w0BAQsFADBmMRswGQYDVQQD
    ExJhMi5zb3VuZGNsb3VkLnRlc3QxCzAJBgNVBAYTAkRFMQ0wCwYDVQQIEwRURVNU
    MQ0wCwYDVQQHEwRURVNUMQ0wCwYDVQQKEwRURVNUMQ0wCwYDVQQLEwRURVNUMB4X
    DTE5MDEwNzEwNDU1N1oXDTIwMDExNTAwMDAwMFowZjEbMBkGA1UEAxMSYTIuc291
    bmRjbG91ZC50ZXN0MQswCQYDVQQGEwJERTENMAsGA1UECBMEVEVTVDENMAsGA1UE
    BxMEVEVTVDENMAsGA1UEChMEVEVTVDENMAsGA1UECxMEVEVTVDCCASIwDQYJKoZI
    hvcNAQEBBQADggEPADCCAQoCggEBAIuMOOGfdiPOAZj+7oYD1G1Pdegj+dcNCOS1
    SZ4GNthPeGsIg/rYRH+mNTvTMfMeaqjCpBXWgUTBxr2r6QzrcgM8nsQiwp/Mdsmk
    Bn0rGdLc2Wak1MtTsAg0bTek5UwcCTT/zg2BS23ZXYocvRWK/O34J4rsyYNtz66u
    gxgjjeBigiJFz81vZ21v6I6IzftvR4+F/UN7xDR8MQCOce8k7pzOyHHkQQi9iBNu
    gAZFjiJLTx+aVMugS4ZCr6Hup6CuBjPFlM42VGWJ8YelY5r6ujiTlq1aG60vE03N
    hapFgCX2lkGVJyQseVQBm8wOt+wMT5LH2G8kVzimF1270hKuc50CAwEAAaOBjjCB
    izAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIC9DAdBgNVHSUEFjAUBggrBgEFBQcD
    AQYIKwYBBQUHAwgwEQYJYIZIAYb4QgEBBAQDAgD1MB0GA1UdDgQWBBRFaYfSh+ON
    llKNUWrLXkAs+lcfeTAdBgNVHREEFjAUghJhMi5zb3VuZGNsb3VkLnRlc3QwDQYJ
    KoZIhvcNAQELBQADggEBADnWWP6ZGh55Xmw6eeB3SPAfUAejLT1x6gcP4pmiwmi8
    2oSz3cQWdNtzEiO9QtbbddYknbZE9V9jHXhTNwkTY0O7Qc4YJ19cmg/QPw7+NHsz
    /xOSxme3Iaf6d17JII16vg5b1i3Emd1IiWwdKCnHzRdx6EM+qgQbVM9tF8a8mty3
    tXQ0i+rkpH9Vp2j6dr49MNiLJD1QA9b5t1TnEfsPm7IfmyxjIuRhmXaZJDaam1gx
    O3c8+n31MVS6/3FpyvsgljxGO/Zd0xyNnnxV13d6fpxYUujGasNDUmcsYF9r6lH3
    UzodLLNBFMdGf6oIxJFdtmJhjEI9PkJWQrjOSi0nKX4=
    -----END CERTIFICATE-----

  ''
];
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.hosts = {
    "163.172.181.40" = ["troy"];
    "127.0.0.1" = ["localhost"];
    "172.17.0.2" = ["docker"];
    # SC related
    "0.0.0.0" = ["checkout.soundcloud.test"
                 "v2.soundcloud.test"
                 "a2.soundcloud.test"];
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };
    bluetooth.powerOnBoot = true;
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
  # This enables a periodically executed systemd service named
  # nixos-upgrade.service. It runs nixos-rebuild switch --upgrade to
  # upgrade NixOS to the latest version in the current channel. (To
  # see when the service runs, see systemctl list-timers.)
  system.autoUpgrade.enable = true;
  system.autoUpgrade.dates = "11:30";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.09"; # Did you read the comment?
}
