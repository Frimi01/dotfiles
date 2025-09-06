{
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

  "group/group-1" = {
    orientation = "horizontal";
    drawer = {
      transition-duration = 500;
      children-class = "not-power";
      transition-left-to-right = false;
    };
    modules = [
      "hyprland/workspaces"
    ];
  };

  "group/group-2" = {
    orientation = "horizontal";
    modules = [
      "cpu"
      "temperature" 
      "disk"
      "memory"
    ];
  };

  "group/group-3" = {
    orientation = "horizontal";
    modules = [
      "wireplumber"
      "backlight"
    ];
  };

  "group/group-4" = {
    orientation = "horizontal";
    modules = [
      "bluetooth"
      "battery"
      "network"
      "custom/power"
      "custom/wallpaper"
    ];
  };

  "group/group-5" = {
    orientation = "horizontal";
    modules = [
      "clock"
    ];
  };

  "group/group-6" = {
    orientation = "horizontal";
    modules = [
      "custom/pacman"
      "custom/pkg-aur"
    ];
  };

  "group/group-9" = {
    orientation = "horizontal";
    modules = [
      "mpris"
      "custom/previous"
      "custom/pause"
      "custom/next"
    ];
  };

  # Module configurations (keep these as-is, just convert JSON syntax to Nix)
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
      "*" = 3;
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
    format-plugged = " {capacity}% <span font='Font Awesome 5 Free'></span> ";
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
      paused = "<span color='#b4befe'> 󰏤  </span>";
    };
    tooltip-format = "Playing: {title} - {artist}";
    tooltip-format-paused = "Paused: {title} - {artist}";
    min-length = 5;
    max-length = 15;
  };

  # Custom modules
  "custom/power" = {
    format = "{icon}";
    format-icons = "";
    exec-on-event = "true";
    on-click = "wlogout";
    tooltip-format = "Power Menu";
  };

  "custom/wallpaper" = {
    format = " ";
    on-click = "~/.config/rofi/wallselect/script.sh";
    tooltip = false;
  };

  "custom/pacman" = {
    format = "  {}";
    interval = 3600;
    exec = "checkupdates | wc -l";
    exec-if = "exit 0";
    on-click = "foot -e 'sudo pacman -Syu'; pkill ZepNet-SIGRTMIN+8 waybar";
    signal = 8;
  };

  "custom/pkg-aur" = {
    exec = "yay -Qua | wc -l";
    interval = 1800;
    format = "󰏔 {}";
    tooltip = true;
    tooltip-format = "AUR packages";
  };

  "custom/previous" = {
    format = "󰙣";
    on-click = "playerctl --player=spotify previous && playerctl --player=youtube-music previous";
    tooltip = false;
  };

  "custom/pause" = {
    format = "{icon}";
    on-click = "playerctl --player=spotify play-pause";
    tooltip = false;
    format-icons = [ "" "" ];
  };

  "custom/next" = {
    format = "󰙡 ";
    on-click = "playerctl --player=spotify next && playerctl --player=youtube-music next";
    tooltip = false;
  };
}
