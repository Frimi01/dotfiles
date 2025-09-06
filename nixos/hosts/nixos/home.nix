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

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 25;
        margin-left = 5;
        margin-right = 5;
        margin-top = 5;
        margin-bottom = 0;
        spacing = 1;
        reload_style_on_change = true;

        modules-left = [
          "group/group-1"
          "group/group-9"
          "group/group-6"
        ];
        modules-center = [
          "group/group-5"
        ];
        modules-right = [
          "group/group-4"
          "group/group-3"
          "group/group-2"
        ];

        # Group Definitions
        "group/group-1" = {
          orientation = "horizontal";
          modules = [ "hyprland/workspaces" ];
        };

        "group/group-2" = {
          orientation = "horizontal";
          modules = [ "cpu" "temperature" "disk" "memory" ];
        };

        "group/group-3" = {
          orientation = "horizontal";
          modules = [ "wireplumber" "backlight" ];
        };

        "group/group-4" = {
          orientation = "horizontal";
          modules = [ "bluetooth" "battery" "network" "custom/power" "custom/wallpaper" ];
        };

        "group/group-5" = {
          orientation = "horizontal";
          modules = [ "clock" ];
        };

        "group/group-6" = {
          orientation = "horizontal";
          modules = [ "custom/pacman" "custom/pkg-aur" ];
        };

        "group/group-9" = {
          orientation = "horizontal";
          modules = [ "mpris" "custom/previous" "custom/pause" "custom/next" ];
        };

        # Module Configurations
        "hyprland/workspaces" = {
          on-click = "activate";
          activate-only = false;
          all-outputs = true;
          format = "{name}";
          format-icons = {
            "1" = "*";
            "2" = "*";
            "3" = "*";
            "4" = "*";
            "5" = "*";
            "6" = "*";
            "7" = "*";
            "8" = "*";
            "9" = "*";
            "10" = "*";
            urgent = "*";
            active = "*";
            default = "*";
          };
          persistent_workspaces = {
            "[]" = 3;
          };
        };

        clock = {
          format = "{:%H:%M - %h %d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        temperature = {
          thermal-zone = 2;
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          format-critical = "{temperatureC}°C {icon}";
          critical-threshold = 80;
          interval = 2;
          format = " {temperatureC:>2}°C";
          format-icons = [ "0" "" "" ];
          on-click = "hyprctl dispatcher togglespecialworkspace monitor";
        };

        cpu = {
          interval = 2;
          format = " {usage:>2}%";
          on-click = "hyprctl dispatcher togglespecialworkspace monitor";
        };

        memory = {
          interval = 2;
          format = " {:>2}%";
        };

        disk = {
          interval = 15;
          format = "󰋊 {percentage_used:>2}%";
        };

        backlight = {
          format = "{icon} {percent:>2}%";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };

        bluetooth = {
          format = "{icon}";
          format-icons = [ "󰂯" "󰤾" "󰥀" "󰥄" "󰥈" ];
          tooltip-format-off = "Bluetooth is off";
          tooltip-format-on = "Bluetooth is on";
          format-connected = "{icon} {num_connections}";
          format-connected-battery = "{icon} {device_battery_percentage}%";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        network = {
          interval = 3;
          format-wifi = "{icon}";
          format-ethernet = "󰌗 {ipaddr}";
          format-linked = "󰌙 {ifname} (Sin IP)";
          format-disconnected = "󰖪";
          format-alt = "󰛳 {ifname}";
          tooltip-format-wifi = " {bandwidthDownBytes}  {bandwidthUpBytes}";
          tooltip-format-ethernet = "󰌗 {ifname} | IP: {ipaddr}/{cidr} | GW: {gwaddr}";
          tooltip-format-disconnected = "󰖪 Sin conexión de red";
          tooltip-format-linked = "󰌙 {ifname}: Not ip";
          max-length = 30;
          on-click = "~/.config/rofi/wifi/script.sh";
          format-icons = {
            wifi = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
            ethernet = [ "󰌗" ];
            disconnected = [ "󰖪" ];
          };
        };

        wireplumber = {
          format = "{icon} {volume:>3}%";
          format-muted = "󰖁 {volume:>3}%";
          format-bluetooth = "{icon} {volume:>2}% 󰂯";
          format-bluetooth-muted = "󰖁 {icon} 󰂯";
          format-icons = [ "" "" "" ];
        };

        battery = {
          states = {
            good = 95;
            warning = 30;
            critical = 15;
          };
          format = "{icon}";
          format-full = "{icon}";
          format-plugged = " {capacity}% <span font='Font Awesome 5 Free'>\uf0e7</span> ";
          format-alt = "{icon} {capacity}%";
          tooltip-format = "{capacity}%, about {time} left";
          format-icons = [ "" "" "" "" ];
        };

        mpris = {
          format = "{player_icon} {title} - {artist} ";
          format-paused = "{status_icon} {title} - {artist}";
          player-icons = {
            default = "<span foreground='#cba6f7'>󰝚 </span>";
            spotify = "<span foreground='#a6e3a1'>󰓇 </span>";
            firefox = "<span foreground='#f38ba8'>󰗃 </span>";
          };
          status-icons = {
            paused = "<span color='#b4befe'>\u200A\u200A󰏤\u2009\u2009</span>";
          };
          tooltip-format = "Playing: {title} - {artist}";
          tooltip-format-paused = "Paused: {title} - {artist}";
          min-length = 5;
          max-length = 15;
        };

        # Custom modules
        "custom/pkg-aur" = {
          exec = "yay -Qua | wc -l";
          interval = 1800;
          format = "󰏔 {}";
          tooltip = true;
          tooltip-format = "AUR packages";
        };

        "custom/power" = {
          format = "{icon}";
          format-icons = "";
          exec-on-event = "true";
          on-click = "wlogout";
          tooltip-format = "Power Menu";
        };

        "custom/pacman" = {
          format = "  {}";
          interval = 3600;
          exec = "checkupdates | wc -l";
          exec-if = "exit 0";
          on-click = "foot -e 'sudo pacman -Syu'; pkill ZepNet-SIGRTMIN+8 waybar";
          signal = 8;
        };

        "custom/wallpaper" = {
          format = " ";
          on-click = "~/.config/rofi/wallselect/script.sh";
          tooltip = false;
        };

        "custom/next" = {
          format = "󰙡 ";
          on-click = "playerctl --player=spotify next && playerctl --player=youtube-music next";
          tooltip = false;
        };

        "custom/pause" = {
          format = "{icon}";
          on-click = "playerctl --player=spotify play-pause";
          tooltip = false;
          format-icons = [ "" "" ];
        };

        "custom/previous" = {
          format = "󰙣";
          on-click = "playerctl --player=spotify previous && playerctl --player=youtube-music previous";
          tooltip = false;
        };
      };
    };
    style = builtins.readFile "${inputs.self}/hosts/nixos/waybar/style.css";
  };

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
