{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

  home.sessionVariables = {
    EDITOR = "nvim";
    JAVA_8_HOME = "${pkgs.jdk8}/lib/openjdk";
    JAVA_21_HOME = "${pkgs.jdk21}/lib/openjdk";
    # GTK_THEME = "Adwaita-dark";
  };
  home.file = {
    ".config/nvim" = {
      source = ../../xdg/config/nvim;
      recursive = true;
    };
  };
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    withRuby = true;
    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      cargo
      unzip
      jdk8
      jdk21
      wget
      curl
      tree-sitter
      luajitPackages.luarocks
      python311Packages.pynvim
      python311Packages.pip
      gcc
    ];
  };


}
