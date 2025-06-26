# home.nix - Place this in your /etc/nixos/ directory
{ config, pkgs, inputs, ... }:

{
  # Home Manager version
  home.stateVersion = "25.05";

  # Basic user info
  home.username = "jacob";
  home.homeDirectory = "/home/jacob";

  # Let Home Manager install and manage itself
  programs.home-manager.enable = true;

  # Development packages managed by Home Manager
  home.packages = with pkgs; [
    # Development tools - Use nodejs_22 consistently
    nodejs_22
    nodePackages.yarn
    nodePackages.npm
    nodePackages.nodemon
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted

    # Languages & runtimes
    go
    flutter  # Flutter includes Dart SDK
    jdk17
    gcc

    # Build tools
    gnumake
    pkg-config

    # Utilities
    ripgrep
    fd
    tree
    htop
    curl
    wget

    # Development services
    mongodb
    mongodb-tools
    postman

    # Applications
    google-chrome
    discord
    obs-studio
    android-studio

    # Fonts
    jetbrains-mono
    fira-code
    font-awesome
  ];

  # Git configuration
  programs.git = {
    enable = true;
    userName = "jacob";
    userEmail = "jakercyber1@gmail.com"; # Replace with your email

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
    };
  };

  # Zsh configuration
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "ls -la";
      la = "ls -A";
      l = "ls -CF";
      grep = "grep --color=auto";
      fgrep = "fgrep --color=auto";
      egrep = "egrep --color=auto";

      # NixOS specific aliases
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      rebuild-test = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
      hm-switch = "home-manager switch --flake /etc/nixos#jacob";
    };

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "node" "npm" "yarn" ];
      theme = "robbyrussell"; # or any theme you prefer
    };
  };

  # Alacritty terminal configuration
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
      };

      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        size = 12;
      };

      colors = {
        primary = {
          background = "#1e1e1e";
          foreground = "#d4d4d4";
        };
      };
    };
  };

  # Tmux configuration
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;

    extraConfig = ''
      # Enable mouse support
      set -g mouse on

      # Split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      # Reload config file
      bind r source-file ~/.tmux.conf

      # Switch panes using Alt-arrow without prefix
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
    '';
  };

  # Neovim configuration (basic setup)
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set number
      set relativenumber
      set tabstop=2
      set shiftwidth=2
      set expandtab
      set smartindent
      set wrap
      set smartcase
      set noswapfile
      set nobackup
      set undodir=~/.vim/undodir
      set undofile
      set incsearch
      set scrolloff=8
      set signcolumn=yes
      set colorcolumn=80
    '';
  };

  # VSCode configuration (basic setup)
  programs.vscode = {
    enable = true;
    profiles.default.userSettings = {
      "editor.fontSize" = 14;
      "editor.fontFamily" = "JetBrains Mono";
      "editor.tabSize" = 2;
      "editor.insertSpaces" = true;
      "editor.formatOnSave" = true;
      "files.autoSave" = "afterDelay";
      "terminal.integrated.defaultProfile.linux" = "zsh";
    };
  };

  # Direnv configuration
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # XDG directories
  xdg.enable = true;

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "google-chrome-stable";
    TERMINAL = "alacritty";
  };

  # Font configuration
  fonts.fontconfig.enable = true;
}
