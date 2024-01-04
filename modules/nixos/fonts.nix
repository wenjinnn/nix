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
      sarasa-gothic
      (nerdfonts.override { fonts = [ "FiraCode" "Ubuntu" "UbuntuMono" "Mononoki" "CascadiaCode" "DejaVuSansMono"]; })
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
          "DejaVuSansM Nerd Font Mono"
          "Sarasa Mono SC"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "DejaVu Sans"
          "Sarasa Sans SC"
          "Noto Sans CJK SC"
        ];
        serif = [
          "DejaVu Serif"
          "Sarasa Serif SC"
          "Noto Serif CJK SC"
        ];
      };
    };
  };
}
