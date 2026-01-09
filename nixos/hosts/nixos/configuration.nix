# NixOS manual (accessible by running ‘nixos-help’).

{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];


  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = false;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Oslo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # VPN config using wireguard
  #  networking.wireguard.enable = true; 

  #  networking.wg-quick.interfaces = {
  #    wg0 = {
  #      address = [ "10.2.0.2/32" ];
  #      dns = [ "10.2.0.1" ];
  #      privateKeyFile = "/etc/wireguard/private.key";  # You may want to use a secret instead
  #
  #      peers = [
  #        {
  #          publicKey = "APcJxf2UbdHXop3dZT3xBj1286WoIxIFSPBdSqCrVS4=";
  #          allowedIPs = [ "0.0.0.0/0" "::/0" ];
  #          endpoint = "185.107.56.162:51820";
  #          persistentKeepalive = 24;
  #        }
  #      ];
  #    };
  #  };


  # Handle graceful shutdown at low power.
	services.upower = {
		enable = true;

		percentageLow = 20;
		percentageCritical = 10;
		percentageAction = 8;
	};

	services.logind.settings.Login = {
			HandleLowBattery = "ignore";
			HandleCriticalPower = "poweroff";
	};

	
  # Enable the X11 windowing system.
  services.xserver.enable = false;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;
  services.desktopManager.gnome.enable = true;
  programs.hyprland.enable = true;
  environment.gnome.excludePackages = with pkgs; [
    baobab # disk usage analyzer
    epiphany # web browser
    gedit # text editor
    simple-scan # document scanner
    totem # video player
    yelp # help viewer
    evince # document viewer
    file-roller # archive manager
    geary # email client

    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-screenshot
    gnome-system-monitor
    gnome-weather
    gnome-disk-utility
    gnome-connections
  ];
  # Intel GPU driver
  # services.videoDrivers = [ "intel" ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # For Vial keyboard configuratoin
  services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  virtualisation.podman = { # Docker though podman
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.frimi01 = {
    isNormalUser = true;
    description = "Mikael";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "kvm" "qemu-libvirtd" "podman" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  users.users.root.hashedPassword = "!";

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "frimi01" = import ./home.nix;
    };
  };



  # Install firefox.
  programs.firefox.enable = true;


  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  wget  
    home-manager
    git
    gcc


    virt-manager # GUI VM manager
    virt-viewer # Optional: View VMs via SPICE
    spice-gtk # SPICE graphical support
    spice-protocol
    virtio-win # VirtIO drivers ISO
    win-spice # SPICE guest tools for Windows
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    #  corefonts
  ];


  services.clamav.daemon.enable = true;
  services.clamav.updater.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # VM support new
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm; # Lighter than default?
        swtpm.enable = false; # Not needed for Windows 10
      };
    };
    spiceUSBRedirection.enable = false; # Optional – disable unless needed
  };
  programs.dconf.enable = true;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "25.05"; # Did you read the comment?

}
