{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  security = {
    polkit.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };
  security.pam.services.gtklock.text = lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";

}
