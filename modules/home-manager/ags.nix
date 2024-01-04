{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];
  # ags
  programs.ags = {
    enable = true;
    configDir = ../../home-manager/xdg-config-home/ags;
    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };

}
