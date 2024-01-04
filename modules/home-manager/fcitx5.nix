{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/fcitx5".source = ../../home-manager/xdg-config-home/fcitx5;
    ".local/share/fcitx5" = {
      source = ../../home-manager/xdg-data-home/fcitx5;
      recursive = true;
    };
  };
  # fcitx5
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-rime
      fcitx5-mozc
    ];
  };
}
