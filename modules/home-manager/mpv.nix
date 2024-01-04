{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    (mpv.override { scripts = [mpvScripts.mpris]; })
  ];
  home.file = {
    ".config/mpv" = {
      source = ../../home-manager/xdg-config-home/mpv;
      recursive = true;
    };
  };
}
