{ config, pkgs, lib, ... }:

{
	home.username = "frimi01";
	home.homeDirectory = "/home/frimi01";

	wayland.windowManager.hyprland.enable = true;
	programs.zoxide.enable = true;
	programs.bash.enable = true;
	programs.alacritty = {
		enable = true;
		#settings = {}
	};
	programs.tmux = {
		enable = true;
		mouse = true;
	};
	home.packages = with pkgs; [
		obsidian
		lazygit
		xclip
		unzip
		vial
		jdk24
		jetbrains.idea-community
	];

	nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
	"obsidian"
	# "corefonts"
	];

	home.file = {
	};

	home.sessionVariables = {
		# EDITOR = "emacs";
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;

	home.stateVersion = "25.05"; # Please read the comment before changing.
}
