{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    ranger
  ];
  home.file = {
    ".config/ranger" = {
      source = ../../home-manager/xdg-config-home/ranger;
      recursive = true;
    };
  };
}
