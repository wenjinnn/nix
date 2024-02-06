{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      (nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" "UbuntuMono" "Mononoki" "CascadiaCode" "DejaVuSansMono" "Noto" ]; })
      font-awesome
      lexend
      material-symbols
    ];
    fontDir.enable = true;
    enableDefaultPackages = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [
          "UbuntuMono Nerd Font Mono"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Ubuntu Nerd Font"
          "Noto Sans CJK SC"
        ];
        serif = [
          "Ubuntu Nerd Font"
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}
