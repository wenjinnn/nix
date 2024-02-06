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
          "NotoSansM Nerd Font Mono"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
        ];
        serif = [
          "Noto Serif CJK SC"
        ];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <description>Disable ligatures for monospaced fonts to avoid ff, fi, ffi, etc. becoming only one character wide</description>
          <match target="font">
            <test name="family" compare="eq" ignore-blanks="true">
              <string>NotoSansM Nerd Font Mono</string>
            </test>
            <edit name="fontfeatures" mode="append">
              <string>liga off</string>
              <string>dlig off</string>
              <string>calt off</string>
              <string>clig off</string>
            </edit>
          </match>
        </fontconfig>
      '';
    };
  };
}
