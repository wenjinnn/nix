{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = with outputs.homeManagerModules; [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    hyprland
    fcitx5
    theme
    mpv
    foot
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1w"
  ];

  home.packages = with pkgs; [
    microsoft-edge
    sassc
    ffmpeg
    gimp
    obs-studio
    unstable.vscode
    scrcpy
    rustdesk
    libreoffice
    evolution
    evolution-ews
    dbeaver
    gnome.gnome-tweaks
    gnome.gnome-themes-extra
    gnome.dconf-editor
    waydroid
    bottles
    telegram-desktop
    discord
    nur.repos.xddxdd.dingtalk
    nur.repos.xddxdd.wechat-uos-bin
    nur.repos.xddxdd.qq
    nur.repos.linyinfeng.wemeet

  ];

}
