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
          ExecStart = "${pkgs.bingwallpaper-get}/bin/bingwallpaper-get";
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
          OnCalendar = "daily";
        };
        Install = { WantedBy = [ "timers.target" ]; };
      };
    };
  };
}
