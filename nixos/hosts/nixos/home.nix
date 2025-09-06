{ config, pkgs, lib, ... }:

{
	home.username = "frimi01";
	home.homeDirectory = "/home/frimi01";

	wayland.windowManager.hyprland.enable = true;
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
		drop_shadow = true;
		shadow_range = 4;
		shadow_render_power = 3;
		"col.shadow" = "rgba(1a1a1aee)";
	};
	
	animations = {
		enabled = true;
		bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
		animation = [
		"windows, 1, 7, myBezier"
		"windowsOut, 1, 7, default, popin 80%"
		"border, 1, 10, default"
		"borderangle, 1, 8, default"
		"fade, 1, 7, default"
		"workspaces, 1, 6, default"
		];
	};

		# keybindings
	bind =
		[
		"$mod, RETURN, exec, alacritty"
		"$mod, F, exec, firefox"
		", Print, exec, grimblast copy area"
		"$mod, D, exec, wofi --show drun"

		"$mod, Q, killactive"           # Close active window
		"$mod, M, exit"                 # Exit Hyprland
		"$mod, V, togglefloating"       # Toggle floating mode
		"$mod, P, pseudo"               # Dwindle layout pseudo-tiling
		"$mod, J, togglesplit"          # Toggle split direction
		
		# Focus movement
		"$mod, left, movefocus, h"
		"$mod, right, movefocus, l" 
		"$mod, up, movefocus, k"
		"$mod, down, movefocus, j"
		
		# Window movement
		"$mod SHIFT, left, movewindow, h"
		"$mod SHIFT, right, movewindow, l"
		"$mod SHIFT, up, movewindow, k"
		"$mod SHIFT, down, movewindow, j"
		
		# Resize windows
		"$mod CTRL, left, resizeactive, -20 0"
		"$mod CTRL, right, resizeactive, 20 0"
		"$mod CTRL, up, resizeactive, 0 -20"
		"$mod CTRL, down, resizeactive, 0 20"
		]
		++ (
		builtins.concatLists (builtins.genList (i:
			let ws = i + 1;
			in [
			"$mod, code:1${toString i}, workspace, ${toString ws}"
			"$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
			]
		) 9)
		);
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
	];

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
	"obsidian"
	# "corefonts"
	];

	home.file = {
	};

	home.sessionVariables = {
		NIXOS_OZONE_WL = "1";  # Force Electron apps to use Wayland
		MOZ_ENABLE_WAYLAND = "1";  # Firefox Wayland support
		QT_QPA_PLATFORM = "wayland";
		SDL_VIDEODRIVER = "wayland";
		_JAVA_AWT_WM_NONREPARENTING = "1";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.stateVersion = "25.05"; # Please read the comment before changing.
}
