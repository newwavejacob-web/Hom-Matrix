# home.nix - Power user configuration with i3 and keyboard-centric tools
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
    # Development tools
    nodejs_22
    nodePackages.yarn
    nodePackages.npm
    nodePackages.nodemon
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    # create-react-app removed - use vite or next.js instead
    nodePackages.pm2
    nodePackages.serve
    insomnia

    # Languages & runtimes
    go
    flutter
    jdk17
    gcc

  
    # Language servers and tools
    nil                           # Nix LSP
    nixpkgs-fmt                   # Nix formatter
    lua-language-server           # Lua LSP
    rust-analyzer                 # Rust LSP
    pyright                       # Python LSP
    nodePackages.typescript-language-server  # TypeScript LSP
    gopls                         # Go LSP
    clang-tools                   # C/C++ LSP
    nodePackages.bash-language-server  # Bash LSP
    nodePackages.vscode-langservers-extracted  # JSON, HTML, CSS LSP
    yaml-language-server          # YAML LSP

  
      # Build tools
    gnumake
    pkg-config

    # Power user terminal utilities
    ripgrep
    fd
    tree
    htop
    curl
    wget
    bat         # Better cat
    eza         # Better ls
    zoxide      # Smart cd
    fzf         # Fuzzy finder
    ranger      # File manager
    ncdu        # Disk usage analyzer
    tldr        # Better man pages
    tokei       # Code statistics
    hyperfine   # Benchmarking tool
    delta       # Better git diff
    lazygit     # Git TUI
    tig         # Git repository browser
    ripgrep
    treesitter

    # Development services
    mongodb
    mongodb-tools
    mongodb-compass
    postman

    # Security/networking tools
    nmap
    wireshark
    tcpdump
    netcat-gnu
    socat
    strace
    ltrace
    gdb
    radare2
    binwalk
    file
    hexdump

    # Applications
    google-chrome
    discord
    obs-studio
    android-studio

    # Compilation and debugging
    lldb
    nasm
    yasm
    binutils

    # DevOps tools
    docker-compose
    jq
    httpie
    k9s                # Kubernetes TUI
    terraform
    ansible

    # Haskell development
    ghc
    cabal-install
    stack
    haskell-language-server
    haskellPackages.hlint
    haskellPackages.ormolu
    haskellPackages.hoogle
    haskellPackages.ghcid

    # Window manager utilities
    nitrogen        # Wallpaper manager
    lxappearance   # Theme configuration
    flameshot      # Screenshot tool
    xfce.thunar    # GUI file manager for when needed

    # System monitoring
    neofetch
    gotop
    iotop

    # Fonts
    jetbrains-mono
    fira-code
    font-awesome
  ];

  # i3 Window Manager Configuration
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = "Mod4"; # Super/Windows key

      keybindings = {
        # Basic i3 bindings
        "Mod4+Return" = "exec alacritty";
        "Mod4+Shift+q" = "kill";
        "Mod4+d" = "exec rofi -show drun";
        "Mod4+Shift+c" = "reload";
        "Mod4+Shift+r" = "restart";
        "Mod4+Shift+e" = "exec i3-nagbar -t warning -m 'Exit i3?' -b 'Yes' 'i3-msg exit'";

        # Focus
        "Mod4+h" = "focus left";
        "Mod4+j" = "focus down";
        "Mod4+k" = "focus up";
        "Mod4+l" = "focus right";

        # Move windows
        "Mod4+Shift+h" = "move left";
        "Mod4+Shift+j" = "move down";
        "Mod4+Shift+k" = "move up";
        "Mod4+Shift+l" = "move right";

        # Split
        "Mod4+g" = "split h";
        "Mod4+v" = "split v";

        # Fullscreen
        "Mod4+f" = "fullscreen toggle";

        # Layout
        "Mod4+s" = "layout stacking";
        "Mod4+w" = "layout tabbed";
        "Mod4+e" = "layout toggle split";

        # Floating
        "Mod4+Shift+space" = "floating toggle";
        "Mod4+space" = "focus mode_toggle";

        # Workspaces
        "Mod4+1" = "workspace number 1";
        "Mod4+2" = "workspace number 2";
        "Mod4+3" = "workspace number 3";
        "Mod4+4" = "workspace number 4";
        "Mod4+5" = "workspace number 5";
        "Mod4+6" = "workspace number 6";
        "Mod4+7" = "workspace number 7";
        "Mod4+8" = "workspace number 8";
        "Mod4+9" = "workspace number 9";
        "Mod4+0" = "workspace number 10";

        # Move to workspace
        "Mod4+Shift+1" = "move container to workspace number 1";
        "Mod4+Shift+2" = "move container to workspace number 2";
        "Mod4+Shift+3" = "move container to workspace number 3";
        "Mod4+Shift+4" = "move container to workspace number 4";
        "Mod4+Shift+5" = "move container to workspace number 5";
        "Mod4+Shift+6" = "move container to workspace number 6";
        "Mod4+Shift+7" = "move container to workspace number 7";
        "Mod4+Shift+8" = "move container to workspace number 8";
        "Mod4+Shift+9" = "move container to workspace number 9";
        "Mod4+Shift+0" = "move container to workspace number 10";

        # Custom applications
        "Mod4+shift+f" = "exec firefox";
        "Mod4+shift+Return" = "exec code";
        "Mod4+shift+n" = "exec thunar";

        # Screenshot
        "Print" = "exec flameshot gui";
        "Mod4+Print" = "exec flameshot full -p ~/Pictures/Screenshots/";

        # Audio controls
        "XF86AudioRaiseVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioLowerVolume" = "exec pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioMute" = "exec pactl set-sink-mute @DEFAULT_SINK@ toggle";

        # Brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl set +5%";
        "XF86MonBrightnessDown" = "exec brightnessctl set 5%-";

        # Media controls
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        # Lock screen
        "Mod4+shift+x" = "exec i3lock -c 000000";
      };

      bars = [
        {
          position = "top";
          statusCommand = "i3status";
          fonts = {
            names = [ "JetBrains Mono" "Font Awesome 6 Free" ];
            size = 11.0;
          };
          colors = {
            background = "#1e1e1e";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };
        }
      ];

      startup = [
        { command = "nitrogen --restore"; always = true; notification = false; }
        { command = "picom"; always = true; notification = false; }
        { command = "dunst"; always = true; notification = false; }
        { command = "networkmanager-applet"; always = true; notification = false; }
      ];

      window = {
        border = 1;
        titlebar = false;
      };

      colors = {
        focused = {
          border = "#4c7899";
          background = "#285577";
          text = "#ffffff";
          indicator = "#2e9ef4";
          childBorder = "#285577";
        };
        focusedInactive = {
          border = "#333333";
          background = "#5f676a";
          text = "#ffffff";
          indicator = "#484e50";
          childBorder = "#5f676a";
        };
        unfocused = {
          border = "#333333";
          background = "#222222";
          text = "#888888";
          indicator = "#292d2e";
          childBorder = "#222222";
        };
        urgent = {
          border = "#2f343a";
          background = "#900000";
          text = "#ffffff";
          indicator = "#900000";
          childBorder = "#900000";
        };
      };
    };
  };

  # Rofi configuration
  programs.rofi = {
    enable = true;
    theme = "Arc-Dark";
    extraConfig = {
      modi = "drun,run,window";
      show-icons = true;
      icon-theme = "Papirus";
      display-drun = "Applications";
      display-run = "Commands";
      display-window = "Windows";
      drun-display-format = "{name}";
      font = "JetBrains Mono 12";
    };
  };

  # Dunst notification daemon
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "JetBrains Mono 10";
        allow_markup = true;
        format = "<b>%s</b>\\n%b";
        sort = true;
        indicate_hidden = true;
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = true;
        ignore_newline = false;
        geometry = "300x5-30+20";
        transparency = 10;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = true;
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        startup_notification = false;
        frame_width = 2;
        frame_color = "#4c7899";
      };
      urgency_low = {
        background = "#222222";
        foreground = "#888888";
        timeout = 10;
      };
      urgency_normal = {
        background = "#285577";
        foreground = "#ffffff";
        timeout = 10;
      };
      urgency_critical = {
        background = "#900000";
        foreground = "#ffffff";
        timeout = 0;
      };
    };
  };

  # Picom compositor
  services.picom = {
    enable = true;
    fade = true;
    fadeDelta = 5;
    shadow = true;
    shadowOpacity = 0.75;
    activeOpacity = 1.0;
    inactiveOpacity = 0.95;
    backend = "glx";
    vSync = true;
  };

  # Git configuration
  programs.git = {
    enable = true;
    userName = "newwavejacob-web";
    userEmail = "ja634925@ucf.edu";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta.navigate = true;
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
    };

    aliases = {
      st = "status";
      co = "checkout";
      br = "branch";
      ci = "commit";
      unstage = "reset HEAD --";
      last = "log -1 HEAD";
      visual = "!gitk";
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    };
  };

  # Zsh configuration with power user enhancements
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ll = "eza -la";
      la = "eza -la";
      l = "eza -l";
      ls = "eza";
      tree = "eza --tree";
      cat = "bat";
      grep = "ripgrep";
      find = "fd";
      cd = "z";

      # Git aliases
      g = "git";
      ga = "git add";
      gc = "git commit";
      gco = "git checkout";
      gst = "git status";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      lg = "lazygit";

      # NixOS specific aliases
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
      rebuild-test = "sudo nixos-rebuild test --flake /etc/nixos#nixos";
      hm-switch = "home-manager switch --flake /etc/nixos#jacob";

      # Development aliases
      v = "nvim";
      c = "code";
      r = "ranger";

      # System monitoring
      top = "btop";
      htop = "btop";
      df = "ncdu";
    };

    history = {
      size = 50000;
      save = 50000;
      path = "${config.xdg.dataHome}/zsh/history";
      ignoreDups = true;
      ignoreSpace = true;
      extended = true;
    };

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
        "node"
        "npm"
        "yarn"
        "z"
        "fzf"
        "tmux"
        "vi-mode"
      ];
      theme = "agnoster";
    };

    # Fixed: Changed from initExtra to initContent
    initContent = ''
      # Initialize zoxide
      eval "$(zoxide init zsh)"

      # FZF configuration
      export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
      export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
      export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

      # Set up fzf key bindings and fuzzy completion
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      source ${pkgs.fzf}/share/fzf/completion.zsh

      # Vim mode indicator
      function zle-keymap-select {
        if [[ $KEYMAP == vicmd ]] || [[ $1 = 'block' ]]; then
          echo -ne '\e[1 q'
        elif [[ $KEYMAP == main ]] || [[ $KEYMAP == viins ]] || [[ $KEYMAP = "" ]] || [[ $1 = 'beam' ]]; then
          echo -ne '\e[5 q'
        fi
      }
      zle -N zle-keymap-select

      # Quick directory navigation
      bindkey -s '^o' 'ranger\n'
      bindkey -s '^g' 'lazygit\n'
    '';
  };

  # Enhanced Alacritty configuration
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        decorations = "full";
        opacity = 0.95;
      };

      font = {
        normal = {
          family = "JetBrains Mono";
          style = "Regular";
        };
        bold = {
          family = "JetBrains Mono";
          style = "Bold";
        };
        italic = {
          family = "JetBrains Mono";
          style = "Italic";
        };
        size = 12;
      };

      colors = {
        primary = {
          background = "#1e1e1e";
          foreground = "#d4d4d4";
        };
        normal = {
          black = "#1e1e1e";
          red = "#f44747";
          green = "#608b4e";
          yellow = "#dcdcaa";
          blue = "#569cd6";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#d4d4d4";
        };
        bright = {
          black = "#5a5a5a";
          red = "#f44747";
          green = "#608b4e";
          yellow = "#dcdcaa";
          blue = "#569cd6";
          magenta = "#c678dd";
          cyan = "#56b6c2";
          white = "#ffffff";
        };
      };

      keyboard.bindings = [
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }
        { key = "Plus"; mods = "Control"; action = "IncreaseFontSize"; }
        { key = "Minus"; mods = "Control"; action = "DecreaseFontSize"; }
        { key = "Key0"; mods = "Control"; action = "ResetFontSize"; }
      ];
    };
  };

  # Enhanced Tmux configuration
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    newSession = true;
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";

    extraConfig = ''
      # Enable mouse support
      set -g mouse on

      # Split panes using | and -
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # New window in current path
      bind c new-window -c "#{pane_current_path}"

      # Reload config file
      bind r source-file ~/.tmux.conf \; display-message "Config reloaded!"

      # Switch panes using Alt-hjkl without prefix
      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Vi mode copy
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"

      # Better colors
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"

      # Status bar
      set -g status-bg colour235
      set -g status-fg colour255
      set -g status-left '#[fg=colour16,bg=colour254,bold] #S #[fg=colour254,bg=colour235,nobold]'
      set -g status-right '#[fg=colour245] %Y-%m-%d %H:%M '
      set -g window-status-format '#[fg=colour245] #I #W '
      set -g window-status-current-format '#[fg=colour16,bg=colour254,bold] #I #W #[fg=colour254,bg=colour235,nobold]'
    '';
  };

  # Enhanced Neovim configuration
  programs.nixvim = {
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  
  # Basic Neovim settings
  opts = {
    # Line numbers
    number = true;
    relativenumber = true;
    
    # Indentation
    expandtab = true;
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    autoindent = true;
    smartindent = true;
    
    # Search
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;
    
    # UI
    termguicolors = true;
    signcolumn = "yes";
    wrap = false;
    cursorline = true;
    
    # Splits
    splitbelow = true;
    splitright = true;
    
    # Backup and swap
    backup = false;
    writebackup = false;
    swapfile = false;
    
    # Completion
    completeopt = ["menu" "menuone" "noselect"];
    
    # Miscellaneous
    mouse = "a";
    clipboard = "unnamedplus";
    undofile = true;
    updatetime = 250;
    timeoutlen = 300;
  };
  
  # Leader key
  globals = {
    mapleader = " ";
    maplocalleader = " ";
  };
  
  # Colorscheme
  colorschemes.catppuccin = {
    enable = true;
    settings = {
      flavour = "mocha"; # or "latte", "frappe", "macchiato"
      transparent_background = false;
      integrations = {
        cmp = true;
        gitsigns = true;
        telescope = true;
        treesitter = true;
        neo_tree = true;
        which_key = true;
      };
    };
  };
  
  # Plugins
  plugins = {
    # LSP Configuration
    lsp = {
      enable = true;
      servers = {
        # Nix
        nil_ls = {
          enable = true;
          settings = {
            formatting = {
              command = ["nixpkgs-fmt"];
            };
          };
        };
        
        # Lua
        lua-ls = {
          enable = true;
          settings = {
            Lua = {
              diagnostics = {
                globals = ["vim"];
              };
              workspace = {
                library = [
                  "\${3rd}/luv/library"
                  "\${3rd}/busted/library"
                ];
              };
            };
          };
        };
        
        # Rust
        rust-analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
        
        # Python
        pyright.enable = true;
        
        # TypeScript/JavaScript
        ts-ls.enable = true;
        
        # Go
        gopls.enable = true;
        
        # C/C++
        clangd.enable = true;
        
        # Bash
        bashls.enable = true;
        
        # JSON
        jsonls.enable = true;
        
        # YAML
        yamlls.enable = true;
        
        # HTML/CSS
        html.enable = true;
        cssls.enable = true;
      };
      
      # LSP keymaps
      keymaps = {
        diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
          "<leader>d" = "open_float";
          "<leader>q" = "setloclist";
        };
        
        lspBuf = {
          "gd" = "definition";
          "gD" = "declaration";
          "gr" = "references";
          "gi" = "implementation";
          "K" = "hover";
          "<C-k>" = "signature_help";
          "<leader>rn" = "rename";
          "<leader>ca" = "code_action";
          "<leader>f" = "format";
        };
      };
    };
    
    # Completion
    cmp = {
      enable = true;
      autoEnableSources = true;
      
      settings = {
        snippet = {
          expand = "function(args) require('luasnip').lsp_expand(args.body) end";
        };
        
        mapping = {
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.abort()";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        };
        
        sources = [
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "buffer"; }
          { name = "path"; }
        ];
      };
    };
    
    # Snippets
    luasnip.enable = true;
    
    # Fuzzy finder
    telescope = {
      enable = true;
      keymaps = {
        "<leader>ff" = "find_files";
        "<leader>fg" = "live_grep";
        "<leader>fb" = "buffers";
        "<leader>fh" = "help_tags";
        "<leader>fd" = "diagnostics";
        "<leader>fr" = "lsp_references";
        "<leader>fs" = "lsp_document_symbols";
        "<leader>fw" = "lsp_workspace_symbols";
      };
      
      settings = {
        defaults = {
          file_ignore_patterns = [
            "node_modules"
            ".git"
            "target"
            "build"
            "dist"
          ];
        };
      };
    };
    
    # Treesitter for syntax highlighting
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = false;
        };
        indent = {
          enable = true;
        };
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "<C-space>";
            node_incremental = "<C-space>";
            scope_incremental = "<C-s>";
            node_decremental = "<C-backspace>";
          };
        };
      };
    };
    
    # File explorer
    neo-tree = {
      enable = true;
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = false;
      };
      filesystem = {
        followCurrentFile = {
          enabled = true;
        };
        hijackNetrwBehavior = "open_current";
      };
    };
    
    # Git integration
    fugitive.enable = true;
    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
        current_line_blame_opts = {
          delay = 300;
        };
      };
    };
    
    # Status line
    lualine = {
      enable = true;
      settings = {
        options = {
          theme = "catppuccin";
          component_separators = {
            left = "|";
            right = "|";
          };
          section_separators = {
            left = "";
            right = "";
          };
        };
        sections = {
          lualine_a = ["mode"];
          lualine_b = ["branch" "diff" "diagnostics"];
          lualine_c = ["filename"];
          lualine_x = ["encoding" "fileformat" "filetype"];
          lualine_y = ["progress"];
          lualine_z = ["location"];
        };
      };
    };
    
    # Key helper
    which-key = {
      enable = true;
      settings = {
        delay = 200;
        expand = 1;
        notify = false;
        preset = false;
        replace = {
          desc = [
            ["<space>" "SPC"]
            ["<leader>" "SPC"]
            ["<cr>" "RET"]
            ["<tab>" "TAB"]
          ];
        };
      };
    };
    
    # Utilities
    comment.enable = true;
    nvim-autopairs.enable = true;
    indent-blankline = {
      enable = true;
      settings = {
        scope = {
          enabled = false;
        };
      };
    };
    
    # Surround text objects
    nvim-surround.enable = true;
    
    # Better buffer deletion
    bufdelete.enable = true;
    
    # Toggle terminal
    toggleterm = {
      enable = true;
      settings = {
        direction = "horizontal";
        size = 20;
        open_mapping = "[[<c-\\>]]";
      };
    };
    
    # Web devicons
    web-devicons.enable = true;
  };
  
  # Custom keymaps
  keymaps = [
    # File explorer
    {
      key = "<leader>e";
      action = ":Neotree toggle<CR>";
      options = {
        desc = "Toggle file explorer";
        silent = true;
      };
    }
    
    # Buffer navigation
    {
      key = "<leader>bn";
      action = ":bnext<CR>";
      options = {
        desc = "Next buffer";
        silent = true;
      };
    }
    {
      key = "<leader>bp";
      action = ":bprevious<CR>";
      options = {
        desc = "Previous buffer";
        silent = true;
      };
    }
    {
      key = "<leader>bd";
      action = ":Bdelete<CR>";
      options = {
        desc = "Delete buffer";
        silent = true;
      };
    }
    
    # Window navigation
    {
      key = "<C-h>";
      action = "<C-w>h";
      options = {
        desc = "Move to left window";
        silent = true;
      };
    }
    {
      key = "<C-j>";
      action = "<C-w>j";
      options = {
        desc = "Move to bottom window";
        silent = true;
      };
    }
    {
      key = "<C-k>";
      action = "<C-w>k";
      options = {
        desc = "Move to top window";
        silent = true;
      };
    }
    {
      key = "<C-l>";
      action = "<C-w>l";
      options = {
        desc = "Move to right window";
        silent = true;
      };
    }
    
    # Clear search highlighting
    {
      key = "<leader>h";
      action = ":nohl<CR>";
      options = {
        desc = "Clear search highlighting";
        silent = true;
      };
    }
    
    # Git shortcuts
    {
      key = "<leader>gs";
      action = ":Git<CR>";
      options = {
        desc = "Git status";
        silent = true;
      };
    }
    {
      key = "<leader>gc";
      action = ":Git commit<CR>";
      options = {
        desc = "Git commit";
        silent = true;
      };
    }
    {
      key = "<leader>gp";
      action = ":Git push<CR>";
      options = {
        desc = "Git push";
        silent = true;
      };
    }
  ];
  
  # Auto commands
  autoCmd = [
    # Highlight yanked text
    {
      event = "TextYankPost";
      pattern = "*";
      callback = {
        __raw = "function() vim.highlight.on_yank({higroup = 'Visual', timeout = 200}) end";
      };
    }
    
    # Remove trailing whitespace on save
    {
      event = "BufWritePre";
      pattern = "*";
      command = "%s/\\s\\+$//e";
    }
  ];
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

  # FZF configuration
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [
      "--height 40%"
      "--layout=reverse"
      "--border"
      "--inline-info"
    ];
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidgetOptions = [
      "--preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    ];
    changeDirWidgetCommand = "fd --type d --hidden --follow --exclude .git";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];
    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };

  # Zoxide (smart cd) configuration
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # Bat (better cat) configuration
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      style = "numbers,changes,header";
      pager = "less -FR";
    };
  };

  # Direnv configuration
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Lazygit configuration
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        theme = {
          lightTheme = false;
          activeBorderColor = ["blue" "bold"];
          inactiveBorderColor = ["white"];
          selectedLineBgColor = ["blue"];
        };
      };
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --dark --paging=never";
        };
      };
    };
  };

  # XDG directories
  xdg.enable = true;

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "google-chrome-stable";
    TERMINAL = "alacritty";
    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
  };

  # Font configuration
  fonts.fontconfig.enable = true;

  # Startup applications (optional)
  home.file.".xprofile".text = ''
    # Set wallpaper
    nitrogen --restore &

    # Start compositor
    picom &

    # Start notification daemon
    dunst &

    # Start network manager applet
    nm-applet &

    # Start bluetooth manager
    blueman-applet &
  '';

  # i3status configuration
  home.file.".config/i3status/config".text = ''
    general {
        colors = true
        interval = 5
        color_good = "#50FA7B"
        color_bad = "#FF5555"
        color_degraded = "#F1FA8C"
    }

    order += "wireless _first_"
    order += "ethernet _first_"
    order += "battery all"
    order += "cpu_usage"
    order += "memory"
    order += "disk /"
    order += "volume master"
    order += "tztime local"

    wireless _first_ {
        format_up = "📶 %quality at %essid"
        format_down = "📶 down"
    }

    ethernet _first_ {
        format_up = "🌐 %ip (%speed)"
        format_down = "🌐 down"
    }

    battery all {
        format = "%status %percentage %remaining"
        format_down = "No battery"
        status_chr = "⚡"
        status_bat = "🔋"
        status_unk = "?"
        status_full = "🔌"
        path = "/sys/class/power_supply/BAT%d/uevent"
        low_threshold = 10
    }

    cpu_usage {
        format = "💻 %usage"
    }

    memory {
        format = "🧠 %used/%available"
        threshold_degraded = "1G"
        format_degraded = "MEMORY < %available"
    }

    disk "/" {
        format = "💾 %avail"
    }

    volume master {
        format = "🔊 %volume"
        format_muted = "🔇 muted (%volume)"
        device = "default"
        mixer = "Master"
        mixer_idx = 0
    }

    tztime local {
        format = "📅 %Y-%m-%d 🕐 %H:%M:%S"
    }
  '';
}
