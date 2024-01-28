{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  systemd.user = {
    services = {
      bingwallpaper-get = {
        Unit = {
          Description = "Download bing wallpaper to target path";
        };
        Service = {
          Type = "oneshot";
          Environment = "HOME=${config.home.homeDirectory}";
          ExecStart = "${pkgs.bingwallpaper-get}/bin/bingwallpaper-get && ${pkgs.swww-switch}/bin/swww-switch 0";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };

      };
    };
    timers = {
      bingwallpaper-get = {
        Unit = {
          Description = "Download bing wallpaper timer";
        };
        Timer = {
          OnCalendar = "hourly";
        };
        Install = { WantedBy = [ "timers.target" ]; };
      };
    };
  };
}
