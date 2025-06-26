# configuration.nix - Updated to work with flakes and Home Manager
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

  # Desktop environment
  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    desktopManager.pantheon.enable = true;
    xkb = {
      layout = "us";
      variant = "";
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

  # User configuration
  users.users.jacob = {
    isNormalUser = true;
    description = "jacob";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    shell = pkgs.zsh;
  };

  # Auto login
  services.displayManager.autoLogin = {
    enable = true;
    user = "jacob";
  };

  # System-wide programs
  programs.firefox.enable = true;
  programs.steam.enable = true;
  programs.adb.enable = true;
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  # System packages (reduced since most moved to Home Manager)
  environment.systemPackages = with pkgs; [
    # Essential system tools
    git
    vim
    wget
    curl

    # Development essentials that should be system-wide
    docker

    # Fonts
    jetbrains-mono
    fira-code
  ];

  # Virtualization
  virtualisation.docker.enable = true;

  # Hardware - Updated deprecated option
  hardware.graphics.enable = true;

  # System version
  system.stateVersion = "25.05";
}
