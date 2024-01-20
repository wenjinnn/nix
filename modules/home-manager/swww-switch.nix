
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
      swww-switch = {
        Unit = {
          Description = "switch randowm wallpaper powered by swww";
        };
        Service = {
          Type = "oneshot";
          Environment = "HOME=${config.home.homeDirectory}";
          ExecStart = "${pkgs.swww-switch}/bin/swww-switch";
        };
        Install = {
          WantedBy = [ "default.target" ];
        };

      };
    };
    timers = {
      swww-switch = {
        Unit = {
          Description = "switch randowm wallpaper powered by swww timer";
        };
        Timer = {
          OnCalendar = "hourly";
        };
        Install = { WantedBy = [ "timers.target" ]; };
      };
    };
  };
}
