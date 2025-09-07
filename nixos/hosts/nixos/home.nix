{ config, pkgs, lib, inputs, ... }:

{
  home.username = "frimi01";
  home.homeDirectory = "/home/frimi01";

  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.extraConfig = builtins.concatStringsSep "\n" [
    (builtins.readFile "${inputs.self}/hosts/nixos/hypr/animations.conf")
    (builtins.readFile "${inputs.self}/hosts/nixos/hypr/keybinds.conf")
  ];

  wayland.windowManager.hyprland.settings = {
    # variables
    "$mod" = "SUPER";

    # startup apps
    exec-once = [
      "waybar"
      "hyprpaper"
      "dunst" # notifications
    ];

    # input
    input = {
      kb_layout = "us";
      follow_mouse = 1;
    };

    # monitor config (auto-detect first monitor)
    monitor = ",preferred,auto,1";

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
      "col.inactive_border" = "rgba(595959aa)";
      layout = "dwindle";
    };

    decoration = {
      rounding = 8;
      blur = {
        enabled = true;
        size = 3;
        passes = 1;
      };
      shadow = {
        enabled = true;
        range = 4;
        render_power = 3;
        color = "rgba(1a1a1aee)";
      };
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = [ "/home/frimi01/Pictures/wallpaper1/wallhaven-2yxp16.jpg" ];

      wallpaper = [
        ",/home/frimi01/Pictures/wallpaper1/wallhaven-2yxp16.jpg"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    style = builtins.readFile "${inputs.self}/hosts/nixos/waybar/style.css";
  };

  xdg.configFile."waybar/config.jsonc".source = "${inputs.self}/hosts/nixos/waybar/config.jsonc";
  xdg.configFile."waybar/power_menu.xml".source =
    "${inputs.self}/hosts/nixos/waybar/power_menu.xml";

  xdg.configFile."wofi/style.css".source =
    "${inputs.self}/hosts/nixos/wofi/style.css";

  xdg.configFile."wlogout/layout".source =
    "${inputs.self}/hosts/nixos/wlogout-layout";

  programs.zoxide.enable = true;

  programs.bash.enable = true;
  programs.alacritty = {
    enable = true;
    #settings = {}
  };
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
  };
  programs.wofi = {
    enable = true;
    settings = {
      width = 600;
      height = 400;
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
    };
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Language servers, formatters, and linters
    extraPackages = with pkgs; [
      nil # Nix LSP
      nixpkgs-fmt # Nix formatter
      statix # Nix linter

      # Java
      jdt-language-server # Java LSP
      google-java-format # Java formatter

      # HTML/CSS
      vscode-langservers-extracted # html, css, json, eslint LSPs
      prettierd # Fast prettier daemon for HTML/CSS/JS

      # Lua
      lua-language-server # Lua LSP
      stylua # Lua formatter

      # JavaScript/TypeScript
      typescript-language-server # TypeScript/JavaScript LSP
      nodePackages.eslint # JavaScript linter

      # Go
      gopls # Go LSP
      gofumpt # Go formatter (stricter than gofmt)
      golangci-lint # Go linter

      # Python
      pyright # Python LSP (faster alternative to pylsp)
      black # Python formatter
      isort # Python import sorter
      ruff # Python linter

      # General tools
      tree-sitter # Better syntax highlighting
    ];
  };



  home.packages = with pkgs; [
    obsidian
    lazygit
    wl-clipboard
    unzip
    vial
    jdk24
    jetbrains.idea-community

    # sys utils
    htop
    fastfetch
    tree
    fd
    ripgrep
    wlogout
    hyprlock

    # hyprland
    pavucontrol
    dunst
    grimblast
    playerctl
    brightnessctl
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
    # "corefonts"
  ];

  home.file = { };

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Force Electron apps to use Wayland
    MOZ_ENABLE_WAYLAND = "1"; # Firefox Wayland support
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    _JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "25.05"; # Please read the comment before changing.
}
