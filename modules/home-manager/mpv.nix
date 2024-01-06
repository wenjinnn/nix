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
      source = ../../xdg/config/mpv;
      recursive = true;
    };
  };
}
