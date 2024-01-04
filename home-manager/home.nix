# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: 
  let 
    electron-flags = [
      "--password-store=gnome-libsecret"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
    ];
  in {
  # You can import other home-manager modules here
  imports = [
    inputs.ags.homeManagerModules.default
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example
    outputs.homeManagerModules.hyprland
    outputs.homeManagerModules.zsh
    outputs.homeManagerModules.foot
    outputs.homeManagerModules.neovim
    outputs.homeManagerModules.git
    outputs.homeManagerModules.fcitx5

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      (self: super: {
        microsoft-edge = super.microsoft-edge.override {
          commandLineArgs = electron-flags;
        };
      })

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  # TODO: Set your username
  home = {
    username = "wenjin";
    homeDirectory = "/home/wenjin";
  };

  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
 
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')/
    microsoft-edge
    neofetch
    sassc
    bat
    fd
    ripgrep
    fzf
    socat
    lazygit
    (mpv.override { scripts = [mpvScripts.mpris]; })
    jq
    ffmpeg
    gimp
    obs-studio
    lsd
    vscode
    cowsay
    file
    which
    tree
    ranger
    gnused
    gnutar
    gawk
    zstd
    scrcpy
    gnupg
    evolution
    evolution-data-server
    du-dust
    lsof
    dbeaver
    btop
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor
    adw-gtk3
    dconf
    gnumake
    cmake
    nodejs
    gcc
    zip
    unzip
    glib
    nautilus-open-any-terminal
    qogir-icon-theme
    gnome.nautilus
    gnome.nautilus-python
    gnome.gnome-tweaks
    gnome.gnome-themes-extra
    waydroid
  ];

  # xresources.properties = {
  #   "Xcursor.size" = 16;
  #   "Xft.dpi" = 172;
  # };


 
 
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    # ".config/qt5ct".source = ./xdg-config-home/qt5ct;
    ".config/ctags".source = ./xdg-config-home/ctags;
    ".config/mpv" = {
      source = ./xdg-config-home/mpv;
      recursive = true;
    };
    ".config/ranger" = {
      source = ./xdg-config-home/ranger;
      recursive = true;
    };
    # ".config/hypr" = {
    #   source = ./xdg-config-home/hypr;
    #   recursive = true;
    # };

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wenjin/etc/profile.d/hm-session-vars.sh
  #

  # Enable home-manager
  programs.home-manager.enable = true;
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Adwaita";
    size = 24;
  };

  qt = {
    enable = true;
    style = {
      package = with pkgs; [
        adwaita-qt
        adwaita-qt6
      ];
      name = "adwaita-dark";
    };
    platformTheme = "gnome";
  };
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };

    font = {
      name = "Sans";
      size = 11;
    };
  };


  dconf.enable = true;
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };


  # ags
  programs.ags = {
    enable = true;
    configDir = ./xdg-config-home/ags;
    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };

  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "DejaVuSansM Nerd Font Mono:size=12";
        dpi-aware = "yes";
        terminal = "${pkgs.foot}/bin/foot -e";
        layer = "overlay";
      };
      colors = {
        background = "171717ff";
        text = "eeeeeeff";
        selection = "373737ff";
        selection-text = "c4c4c4ff";
        border = "1f1f1fff";
        match = "5ba9e8ff";
        selection-match = "5ba9e8ff";
      };
      dmenu = {
        exit-immediately-if-empty="yes";
      };
      border = {
        width = 1;
      };
    };
  };


  services = {
    # kdeconnect = {
    #   enable = true;
    #   indicator = true;
    # };
    xsettingsd = {
      enable = true;
      settings = {
        "Gdk/UnscaledDPI" = 98304;
        "Gdk/WindowScalingFactor" = 2;
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
