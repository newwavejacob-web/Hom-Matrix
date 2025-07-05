# configuration.nix - Power user keyboard-centric configuration
{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Nix configuration
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # Garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Time zone and locale
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # X11 and Window Manager setup
  services.xserver = {
    enable = true;
    dpi = 156;
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu           # Application launcher
        i3status        # Status bar
        i3lock          # Screen locker
        i3blocks        # Alternative status bar
        rofi            # Better application launcher
        polybar         # Modern status bar
        picom           # Compositor for transparency/effects
        feh             # Wallpaper setter
        maim            # Screenshot tool
        xclip           # Clipboard manager
        xorg.xrandr     # Display configuration
        arandr          # GUI for xrandr
        autorandr       # Automatic display configuration
        dunst           # Notification daemon
        redshift        # Blue light filter
        playerctl       # Media player control
        brightnessctl   # Brightness control
        pavucontrol     # Audio control GUI
        blueman         # Bluetooth manager
      ];
    };
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Display manager configuration
  services.xserver.displayManager.lightdm.enable = true;
  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true;
      user = "jacob";
    };
  };

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Printing
  services.printing.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Location service for redshift
  location.provider = "geoclue2";
  services.redshift = {
    enable = true;
    brightness = {
      day = "1";
      night = "0.8";
    };
    temperature = {
      day = 5500;
      night = 3700;
    };
  };

  # User configuration
  users.users.jacob = {
    isNormalUser = true;
    description = "jacob";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" "video" "audio" ];
    shell = pkgs.zsh;
  };

  # System-wide programs
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.adb.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # System packages
  environment.systemPackages = with pkgs; [
    # Essential system tools
    git
    vim
    wget
    curl

    # Development essentials that should be system-wide
    docker

    # Fonts for better text rendering
    jetbrains-mono
    fira-code
    font-awesome

    # System utilities for power users
    htop
    btop
    tree
    fd
    ripgrep
    bat
    eza
    zoxide

    # Terminal multiplexer and session management
    tmux

    # File manager
    ranger

    # Network tools
    networkmanagerapplet
  ];

  # Virtualization
  virtualisation.docker.enable = true;

  # Hardware
  hardware.graphics.enable = true;

  # Security
  security.sudo.wheelNeedsPassword = false; # Optional: passwordless sudo for wheel group

  # Fonts - Fixed nerdfonts configuration
  fonts.packages = with pkgs; [
    jetbrains-mono
    fira-code
    font-awesome
    # New nerd fonts syntax
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
  ];

  # System version
  system.stateVersion = "25.05";
}
