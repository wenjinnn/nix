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
    # ".config/hypr" = {
    #   source = ./xdg-config-home/hypr;
    #   recursive = true;
    # };
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

  # foot
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        shell = "zsh";
        term = "xterm-256color";
        font = "DejaVuSansM Nerd Font Mono:size=12";
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
        systemd.enable = true;
        settings = {
          env = [
            "XMODIFIERS, @im=fcitx"
            "QT_IM_MODULE, fcitx"
            "SDL_IM_MODULE, fcitx"
            "QT_QPA_PLATFORMTHEME, qt5ct"
            "GDK_BACKEND, wayland,x11"
            "QT_QPA_PLATFORM, wayland;xcb"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
            "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
            "CLUTTER_BACKEND, wayland"
            "ADW_DISABLE_PORTAL, 1"
            "XCURSOR_SIZE, 24"
          ];
          exec-once = [
            "sleep 1 && swww init && swww img ~/.config/eww/images/wallpaper --transition-fps 60 --transition-type random --transition-pos && systemctl --user start swww-next.timer &"
            "ags -b hypr"
            "fcitx5 -d --replace"
            "gnome-keyring-daemon --start --components=secrets"
            "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
            "kdeconnect-indicator"
            "udiskie &"
            "swayidle -w timeout 300 'gtklock -d' timeout 360 'hyprctl dispatch dpms off' after-resume 'hyprctl dispatch dpms on' before-sleep 'gtklock -d && sleep 1 && hyprctl dispatch dpms off'"
            "wl-paste --watch cliphist store"
            "libinput-gestures-setup start"
            "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
            "hyprctl dispatch exec [workspace special:monitor silent] foot btop"
            "hyprctl dispatch exec [workspace special:kdeconnect silent] kdeconnect-app"
            "hyprctl dispatch exec [workspace special:windows silent] \"virt-manager --no-fork --show-domain-console win10 -c qemu:///system\""
          ];
          monitor = [
            ",highres,auto,auto"
            "eDP-1, addreserved, 0, 0, 0, 0"
            "eDP-1, highres,auto,2"
          ];
          input = {
            force_no_accel = false;

            kb_layout = "us";
            follow_mouse = 1;
            numlock_by_default = true;
            scroll_method = "2fg";

            touchpad = {
                natural_scroll = "yes";
                disable_while_typing = true;
                clickfinger_behavior = true;
                scroll_factor = 0.7;
            };
          };
          gestures = {
            # See https://wiki.hyprland.org/Configuring/Variables/ for more
            workspace_swipe = true;
            workspace_swipe_distance = "1200px";
            workspace_swipe_fingers = 4;
            workspace_swipe_cancel_ratio = 0.2;
            workspace_swipe_min_speed_to_force = 5;
            workspace_swipe_create_new = true;
          };
          general = {
            layout = "dwindle";
            no_focus_fallback = true;
          };
          dwindle = {
            preserve_split = true;
          };
          decoration = {
	        rounding = 10;
            drop_shadow = "yes";
            shadow_range = 8;
            shadow_render_power = 2;
            "col.shadow" = "rgba(00000044)";

            dim_inactive = false;

            blur = {
              enabled = true;
              size = 8;
              passes = 3;
              new_optimizations = "on";
              noise = 0.01;
              contrast = 0.9;
              brightness = 0.8;
            };
          };
          animations = {
            enabled = true;
            bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
            animation = [
              "windows, 1, 5, myBezier"
              "windowsOut, 1, 7, default, popin 80%"
              "border, 1, 10, default"
              "fade, 1, 7, default"
              "workspaces, 1, 6, default"
            ];
          };
          misc = {
            vfr = true;
            vrr = 1;
            focus_on_activate = true;
            animate_manual_resizes = false;
            animate_mouse_windowdragging = false;
            #suppress_portal_warnings = true
            enable_swallow = true;
            mouse_move_enables_dpms = true;
            key_press_enables_dpms = true;
            disable_hyprland_logo = true;
            force_hypr_chan = true;
          };
          xwayland = {
            force_zero_scaling = true;
          };
          windowrule = [
            "float, ^(steam)$"
            "tile,title:^(WPS)(.*)$"
            # Dialogs
            "float,title:^(Open File)(.*)$"
            "float,title:^(Open Folder)(.*)$"
            "float,title:^(Save As)(.*)$"
            "float,title:^(Library)(.*)$"
            "nofocus,title:^(.*)(mvi)$"
          ];
          windowrulev2 = [
            "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
            "noanim,class:^(xwaylandvideobridge)$"
            "nofocus,class:^(xwaylandvideobridge)$"
            "noinitialfocus,class:^(xwaylandvideobridge)$"
          ];
          layerrule = [
            "blur, gtk-layer-shell"
            "ignorezero, gtk-layer-shell"
          ];
          bind = let e = "exec, ags -b hypr"; in [

            "ControlSuper, Q, killactive,"
            "ControlSuper, Space, togglefloating, "
            "ControlSuperShift, Space, pin, "
            "ControlShiftSuper, Q, exec, hyprctl kill"
            "Super, Return, exec, foot"
            "SUPER, I, exec, XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
            "ControlSuperShiftAlt, E, exit,"
            ", XF86PowerOff, ${e} -t powermenu"
            "Super, Tab,     ${e} -t overview"
            ", XF86Launch4,  ${e} -r 'recorder.start()'"
            ",Print,         ${e} -r 'recorder.screenshot()'"
            "Shift,Print,    ${e} -r 'recorder.screenshot(true)'"
            "ControlSuperShiftAlt, L, exec, gtklock"
            "ControlSuperShiftAlt, D, exec, systemctl poweroff"
            # Applauncher
            "Super, D, exec, ags -b hypr -t applauncher"
            # Snapshot
            "SuperShift, S, exec, grim -g \"$(slurp)\" - | wl-copy"
            # Swap windows
            "SuperShift, H, movewindow, l"
            "SuperShift, L, movewindow, r"
            "SuperShift, K, movewindow, u"
            "SuperShift, J, movewindow, d"
            # Move focus
            "Super, H, movefocus, l"
            "Super, L, movefocus, r"
            "Super, K, movefocus, u"
            "Super, J, movefocus, d"
            # Workspace, window, tab switch with keyboard
            "ControlSuper, right, workspace, +1"
            "ControlSuper, left, workspace, -1"
            "ControlSuper, BracketLeft, workspace, -1"
            "ControlSuper, BracketRight, workspace, +1"
            "ControlSuper, up, workspace, -5"
            "ControlSuper, down, workspace, +5"
            "Super, Page_Down, workspace, +1"
            "Super, Page_Up, workspace, -1"
            "ControlSuper, Page_Down, workspace, +1"
            "ControlSuper, Page_Up, workspace, -1"
            "SuperShift, Page_Down, movetoworkspace, +1"
            "SuperShift, Page_Up, movetoworkspace, -1"
            "Controlsuper, L, movetoworkspace, +1"
            "Controlsuper, H, movetoworkspace, -1"
            "SuperShift, mouse_down, movetoworkspace, -1"
            "SuperShift, mouse_up, movetoworkspace, +1"
            # Fullscreen
            "Super, F, fullscreen, 1"
            "SuperShift, F, fullscreen, 0"
            "ControlSuper, F, fakefullscreen, 0"
            # Switching
            "Super, 1, workspace, 1"
            "Super, 2, workspace, 2"
            "Super, 3, workspace, 3"
            "Super, 4, workspace, 4"
            "Super, 5, workspace, 5"
            "Super, 6, workspace, 6"
            "Super, 7, workspace, 7"
            "Super, 8, workspace, 8"
            "Super, 9, workspace, 9"
            "Super, 0, workspace, 10"
            "Super, S, togglespecialworkspace"
            "Super, M, togglespecialworkspace, monitor"
            "Super, W, togglespecialworkspace, windows"
            "Super, E, togglespecialworkspace, evolution"
            "Super, C, togglespecialworkspace, kdeconnect"
            # bind = SUPER, Tab, cyclenext
            "Super, Tab, exec, ags -b hypr -t overview"
            "Super, Tab, bringactivetotop,   # bring it to the top"
            # Move window to workspace Control + Super + [0-9] 
            "ControlSuper, 1, movetoworkspacesilent, 1"
            "ControlSuper, 2, movetoworkspacesilent, 2"
            "ControlSuper, 3, movetoworkspacesilent, 3"
            "ControlSuper, 4, movetoworkspacesilent, 4"
            "ControlSuper, 5, movetoworkspacesilent, 5"
            "ControlSuper, 6, movetoworkspacesilent, 6"
            "ControlSuper, 7, movetoworkspacesilent, 7"
            "ControlSuper, 8, movetoworkspacesilent, 8"
            "ControlSuper, 9, movetoworkspacesilent, 9"
            "ControlSuper, 0, movetoworkspacesilent, 10"
            "ControlShiftSuper, Up, movetoworkspacesilent, special"
            "ControlSuper, S, movetoworkspacesilent, special"
            # Scroll through existing workspaces with (Control) + Super + scroll
            "Super, mouse_up, workspace, +1"
            "Super, mouse_down, workspace, -1"
            "ControlSuper, mouse_up, workspace, +1"
            "ControlSuper, mouse_down, workspace, -1"
            # Move/resize windows with Super + LMB/RMB and dragging
            "ControlSuper, Backslash, resizeactive, exact 640 480"
          ];
          bindm = [
            # Move/resize windows with Super + LMB/RMB and dragging
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
            "Super, mouse:274, movewindow"
            "Super, Z, movewindow"
          ];
          binde = [
            # Window split ratio
            "SUPER, Minus, splitratio, -0.1"
            "SUPER, Equal, splitratio, 0.1"
            "SUPER, Semicolon, splitratio, -0.1"
            "SUPER, Apostrophe, splitratio, 0.1"
          ];
          bindr = let e = "exec, ags -b hypr -r"; in [
            "ControlSuperShiftAlt, R, exec, ags -b hypr quit; ags -b hypr"
          ];
          bindl = let e = "exec, ags -b hypr -r"; in [
            ",Print,exec,grim - | wl-copy"
            "ControlSuperShiftAlt, S, exec, systemctl suspend"
            ",XF86AudioPlay,    ${e} 'mpris?.playPause()'"
            ",XF86AudioStop,    ${e} 'mpris?.stop()'"
            ",XF86AudioPause,   ${e} 'mpris?.pause()'"
            ",XF86AudioPrev,    ${e} 'mpris?.previous()'"
            ",XF86AudioNext,    ${e} 'mpris?.next()'"
            ",XF86AudioMicMute, ${e} 'audio.microphone.isMuted = !audio.microphone.isMuted'"
          ];
          bindle = let e = "exec, ags -b hypr -r"; in [
            ",XF86MonBrightnessUp,   ${e} 'brightness.screen += 0.05; indicator.display()'"
            ",XF86MonBrightnessDown, ${e} 'brightness.screen -= 0.05; indicator.display()'"
            ",XF86KbdBrightnessUp,   ${e} 'brightness.kbd++; indicator.kbd()'"
            ",XF86KbdBrightnessDown, ${e} 'brightness.kbd--; indicator.kbd()'"
            ",XF86AudioRaiseVolume,  ${e} 'audio.speaker.volume += 0.05; indicator.speaker()'"
            ",XF86AudioLowerVolume,  ${e} 'audio.speaker.volume -= 0.05; indicator.speaker()'"
          ];
        };
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
