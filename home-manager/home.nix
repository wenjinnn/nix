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
    (python311.withPackages (p: [ p.python-pam ]))
    bat
    fd
    ripgrep
    fzf
    socat
    lazygit
    (mpv.override { scripts = [mpvScripts.mpris]; })
    jq
    ffmpeg
    hyprpicker
    wf-recorder
    imagemagick
    slurp
    wl-gammactl
    tesseract
    pavucontrol
    brightnessctl
    lsd
    vscode
    cowsay
    file
    which
    tree
    lsd
    ranger
    gnused
    gnutar
    gawk
    zstd
    gnupg
    du-dust
    lsof
    dbeaver
    swayidle
    udiskie
    btop
    zsh-powerlevel10k
    swww
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    adwaita-qt6
    adwaita-qt
    adw-gtk3
    dconf
    nwg-look
    gtklock
    gtklock-userinfo-module
    gtklock-powerbar-module
    gtklock-playerctl-module
    gnumake
    cmake
    nodejs
    gcc
    zip
    unzip
    cliphist
    glib
    wl-clipboard
    wl-gammactl
    gnome-extension-manager
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

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };

 
 
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
    ".config/fcitx5".source = ./xdg-config-home/fcitx5;
    ".config/qt5ct".source = ./xdg-config-home/qt5ct;
    ".config/ctags".source = ./xdg-config-home/ctags;
    ".config/mpv" = {
      source = ./xdg-config-home/mpv;
      recursive = true;
    };
    ".local/share/fcitx5" = {
      source = ./xdg-data-home/fcitx5;
      recursive = true;
    };
    ".config/nvim" = {
      source = ./xdg-config-home/nvim;
      recursive = true;
    };
    ".config/ranger" = {
      source = ./xdg-config-home/ranger;
      recursive = true;
    };
    ".config/hypr" = {
      source = ./xdg-config-home/hypr;
      recursive = true;
    };
    ".config/gtklock/config.ini".text = ''
      [main]
      gtk-theme=adw-gtk3-dark
      modules=${pkgs.gtklock-powerbar-module}/lib/gtklock/powerbar-module.so;${pkgs.gtklock-playerctl-module}/lib/gtklock/playerctl-module.so;${pkgs.gtklock-userinfo-module}/lib/gtklock/userinfo-module.so
      time-format=%T
    '';

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
  home.sessionVariables = {
    EDITOR = "nvim";
    # GTK_THEME = "Adwaita-dark";
  };

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
    platformTheme = "gtk";
    style.name = "adwaita-dark";
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

  # git
  programs.git = {
    enable = true;
    userName = "wenjin";
    userEmail = "hewenjin94@outlook.com";
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = "wenjinnn";
      push.autoSetupRemote = true;
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

  # ags
  programs.ags = {
    enable = true;
    configDir = ./xdg-config-home/ags;
    extraPackages = with pkgs; [
      libgtop
      libsoup_3
    ];
  };

  # foot
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "zsh";
        term = "xterm-256color";
        font = "FiraCode Nerd Font Mono:size=12";
        letter-spacing=0;
        dpi-aware="no";
        bold-text-in-bright="no";
      };
      scrollback = {
        lines = 10000;
      };
      cursor = {
        color = "1e1e1e cccccc";
      };
      colors = {
        alpha=0.8;
        background="1e1e1e";
        foreground="cccccc";
        regular0="000000";
        regular1="cd3131";
        regular2="0dbc79";
        regular3="e5e510";
        regular4="2472c8";
        regular5="bc3fbc";
        regular6="11a8cd";
        regular7="e5e5e5";
        bright0="666666";
        bright1="f14c4c";
        bright2="23d18b";
        bright3="f5f543";
        bright4="3b8eea";
        bright5="d670d6";
        bright6="29b8db";
        bright7="e5e5e5";

      };
      key-bindings = {
        scrollback-up-page="Control+Shift+Page_Up";
        scrollback-down-page="Control+Shift+Page_Down";
        clipboard-copy="Control+Shift+c";
        clipboard-paste="Control+Shift+v";
        search-start="Control+Shift+f";
      };
      search-bindings = {
        cancel="Escape";
        commit="Return";
        find-prev="Control+Shift+p";
        find-next="Control+Shift+n";
      };
    };
  };

  # zsh
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    history = {
      size = 99999;
      ignoreAllDups = true;
    };
    syntaxHighlighting = {
      enable = true;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "svn"
        "mvn"
        "docker"
        "wd"
        "z"
        "history"
        "extract"
        "fzf"
        "sudo"
      ];
    };
    shellAliases = {
      lg = "lazygit";
      ll = "lsd -lah";
      py = "python";
      rr = "ranger";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./dotfiles;
        file = ".p10k.zsh";
      }
    ];
    initExtra = ''
      export LANG=en_US.UTF-8
      if [[ -n "''${IS_NVIM_DAP_TOGGLETERM}" ]]; then
          return
      fi
      # TMUX
      if [ -x "$(command -v tmux)" ] && [ -n "''${DISPLAY}" ] && [ "''${TERM_PROGRAM}" != "vscode" ] && [ "''${XDG_SESSION_DESKTOP}" != "hyprland" ] && [ -z "''${TMUX}" ]; then
          tmux attach || tmux >/dev/null 2>&1
      fi
      COMPLETION_WAITING_DOTS="true"
      bindkey '^ ' autosuggest-accept
      PROXY_ENV=(http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY)
      NO_PROXY_ENV=(no_proxy NO_PROXY)
      proxy_value=http://127.0.0.1:7890
      no_proxy_value=localhost,127.0.0.1,localaddress,.localdomain.com,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.49.2/24

      proxyIsSet(){
          for envar in $PROXY_ENV
          do
              eval temp=$(echo \$$envar)
              if [ $temp ]; then
                  return 0
              fi
          done
          return 1

      }

      assignProxy(){
          for envar in $PROXY_ENV
          do
             export $envar=$1
          done
          for envar in $NO_PROXY_ENV
          do
             export $envar=$2
          done
          echo "set all proxy env done"
          echo "proxy value is:"
          echo ''${proxy_value}
          echo "no proxy value is:"
          echo ''${no_proxy_value}
      }

      clrProxy(){
          for envar in $PROXY_ENV
          do
              unset $envar
          done
          echo "cleaned all proxy env"
      }

      # toggleProxy
      tp(){
          if proxyIsSet 
          then
              clrProxy
          else
              # user=YourUserName
              # read -p "Password: " -s pass &&  echo -e " "
              # proxy_value="http://$user:$pass@ProxyServerAddress:Port"
              assignProxy $proxy_value $no_proxy_value
          fi
      }

      timestamp(){
          current=`date "+%Y-%m-%d %H:%M:%S"`
          if [ $1 ] ;then
              current=$1
              echo $current
          fi

          timeStamp=`date -d "$current" +%s`
          currentTimeStamp=$((timeStamp*1000+`date "+%N"`/1000000))
          echo $currentTimeStamp
      }
      '';
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

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


  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    xsettingsd = {
      enable = true;
      settings = {
        "Gdk/UnscaledDPI" = 98304;
        "Gdk/WindowScalingFactor" = 2;
      };
    };
  };
  # hyprland
  wayland = {
    windowManager = {
      hyprland = {
        enable = true;
        xwayland.enable = true;
        # systemd.enable = true;
        # settings = {
        #
        # };
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
