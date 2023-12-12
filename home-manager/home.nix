# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
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
    # '')
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
    mpv
    jq
    ffmpeg
    lsd
    cowsay
    file
    which
    tree
    ranger
    gnused
    gnutar
    gawk            
    zstd            
    gnupg           
    du-dust         
    lsof            
    dbeaver
    btop
    zsh-powerlevel10k
    swww
    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    gnumake
    cmake
    gcc
    zip
    unzip
    glib
    wl-clipboard
    wl-gammactl
    gnome-extension-manager
    nautilus-open-any-terminal
    qogir-icon-theme
    gnome.nautilus-python
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
  };

  # Enable home-manager
  programs.home-manager.enable = true;


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
    fcitx5.addons = with pkgs; [ fcitx5-rime ];
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
      ll = "ls -lah";
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
  home.file."./.config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/project/my/nix-config/home-manager/xdg-config-home/nvim";


  services = {
    kdeconnect = {
      enable = true;
      indicator = true;
    };
    xsettingsd = {
      enable = true;
      # settings = {
      #   "Gdk/UnscaledDPI" = 98304;
      #   "Gdk/WindowScalingFactor" = 2;
      # };
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

        };
        extraConfig = ''
          env = XMODIFIERS, @im=fcitx
          # env = GTK_IM_MODULE, fcitx
          env = QT_IM_MODULE, fcitx
          env = SDL_IM_MODULE, fcitx
          env = QT_QPA_PLATFORMTHEME, qt5ct
          env = GDK_BACKEND, wayland,x11
          env = QT_QPA_PLATFORM, wayland;xcb
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          env = CLUTTER_BACKEND, wayland
          # env = QT_SCALE_FACTOR, 2
          #env = WLR_NO_HARDWARE_CURSORS, 1
          #env = GLFW_IM_MODULE, ibus
          #env = GDK_SYNCHRONIZE, 1
          env = LANG, en_US.UTF-8
          # toolkit-specific scale
          # env = GDK_SCALE,2
          env = XCURSOR_SIZE,24

          # Wallpaper
          # exec-once = swaybg -i ~/.config/eww/images/wallpaper/wallpaper
          exec-once = sleep 1 && swww init && swww img ~/.config/eww/images/wallpaper --transition-fps 60 --transition-type random --transition-pos "''${cursorposx:-0}, ''${cursorposy_inverted:-0}" && systemctl --user start swww-next.timer &
          
          # Status bar
          #exec-once = waybar
          #exec-once = eww daemon && eww open winbar &
          # exec-once = eww daemon && eww open bar && eww open bgdecor &
          exec-once = ags -b hypr
          
          # Language Switch
          # sets xwayland scale
          # exec-once = echo "Xft.dpi: 192" | xrdb -merge && xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2
          exec-once = systemctl --user start xsettingsd.service && echo "Xft.dpi: 192" | xrdb -merge
          
          # Core components (authentication, lock screen, notification daemon)
          exec-once = dbus-update-activation-environment --all
          exec-once = /usr/bin/gnome-keyring-daemon --start --components=secrets
          exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
          # exec-once = dunst &
          exec-once = fcitx5 -d --replace
          # exec-once = nm-applet
          # exec-once = blueberry-tray &
          exec-once = kdeconnect-indicator
          exec-once = udiskie &
          # exec-once = swayidle -w before-sleep 'gtklock' &
          # exec-once = swayidle -w timeout 450 'systemctl suspend'
          exec-once = swayidle -w timeout 300 'gtklock -d' timeout 360 'hyprctl dispatch dpms off' after-resume 'hyprctl dispatch dpms on' before-sleep 'gtklock -d && sleep 1 && hyprctl dispatch dpms off'
          # Clipboard history
          exec-once = wl-paste --watch cliphist store
          
          # Cursor and Touchpad gestures
          # exec-once = hyprctl setcursor Bibata-Modern-Classic 24
          exec-once = libinput-gestures-setup start
          
          exec-once = sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          
          exec-once = hyprctl dispatch exec [workspace special:monitor silent] foot btop
          exec-once = hyprctl dispatch exec [workspace special:evolution silent] evolution
          exec-once = hyprctl dispatch exec [workspace special:kdeconnect silent] kdeconnect-app
          exec-once = hyprctl dispatch exec [workspace special:windows silent] "virt-manager --no-fork --show-domain-console win10 -c qemu:///system"
                    
          ############################# Monitor ############################
          monitor=,highres,auto,auto
          monitor=eDP-1, addreserved, 40, 0, 0, 0
          monitor=eDP-1, highres,auto,2
          # monitor=eDP-1,1920x1080@60,1920x0,1,mirror,eDP-1  # screen mirror for laptop -> hdmi
          # monitor=eDP-1,3840x2400@60,0x0,2
          
          ############################## Input ##############################
          input {
              # Mouse
              # accel_profile = adaptive
              force_no_accel = false
              #sensitivity = 0
          
              # Keyboard
              kb_layout = us
              follow_mouse = 1
              numlock_by_default = true
          
              touchpad {
                  natural_scroll = yes
                  disable_while_typing = true
                  clickfinger_behavior = true
                  scroll_factor = 0.7
              }
              scroll_method = 2fg
          }
          
          gestures {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              workspace_swipe = true
              workspace_swipe_distance = 1200px
              workspace_swipe_fingers = 4
              workspace_swipe_cancel_ratio = 0.2
              workspace_swipe_min_speed_to_force = 5
              workspace_swipe_create_new = true
          }
          
          general {
              # Gaps and border
              gaps_in = 4
              gaps_out = 4
              border_size = 2
              
              # Fallback colors
              col.active_border = rgba(0DB7D4FF) rgba(7AA2F7FF) rgba(9778D0FF) 45deg
              col.inactive_border = rgba(04404aaa)
          
              # Functionality
              # resize_on_border = true
              no_focus_fallback = true
              layout = dwindle
          }
          
          dwindle {
          	preserve_split = true # you probably want this
          	#no_gaps_when_only = true
          }
          
          decoration {
          	# Blur rules
          	rounding = 15
              
              # Shadow
              drop_shadow = false
              shadow_range = 30
              shadow_render_power = 10
              col.shadow = rgba(2D3031FF)
              # Blur
           
              blur {
                  enabled = true
                  xray = true
                  size = 12
                  passes = 4
                  new_optimizations = on
                  
                  noise = 0.02
                  contrast = 1.6
                  brightness = 1.1
                  special = false
                  
                  #contrast = 1
                  #brightness = 1
                  
              }
              
              # Shader
              # screen_shader = ~/.config/hypr/shaders/nothing.frag
              
              # Dim
              dim_inactive = false
              dim_strength = 0.1
              dim_special = 0
          }
          
          
          animations {
              enabled = true
              # Animation curves
              
              bezier = md3_standard, 0.2, 0, 0, 1
              bezier = md3_decel, 0.05, 0.7, 0.1, 1
              bezier = md3_accel, 0.3, 0, 0.8, 0.15
              bezier = overshot, 0.05, 0.9, 0.1, 1.1
              bezier = crazyshot, 0.1, 1.5, 0.76, 0.92 
              bezier = hyprnostretch, 0.05, 0.9, 0.1, 1.0
              bezier = fluent_decel, 0.1, 1, 0, 1
              # Animation configs
              # animation = windows, 1, 2, md3_decel, popin
              animation = border, 1, 10, default
              # animation = fade, 1, 2, default
              # animation = workspaces, 1, 3, md3_decel
              # animation = specialWorkspace, 1, 3, md3_decel, slidevert
          }
          
          misc {
              vfr = true
              vrr = 1
              focus_on_activate = true
              animate_manual_resizes = false
              animate_mouse_windowdragging = false
              #suppress_portal_warnings = true
              enable_swallow = true
              mouse_move_enables_dpms = true
              key_press_enables_dpms = true
              
              disable_hyprland_logo = true
              force_hypr_chan = true
          }
          
          debug {
          	#overlay = true
          	#damage_tracking=0
          }
          
          decoration {
            #screen_shader = ~/.config/hypr/shaders/drugs.frag
            #screen_shader = ~/.config/hypr/shaders/crt.frag
          }
          
          # unscale XWayland
          xwayland {
            force_zero_scaling = true
          }
          
          ######## Window rules ########
          windowrule = float, ^(steam)$
          windowrule = tile,title:^(WPS)(.*)$
          
          # Dialogs
          windowrule=float,title:^(Open File)(.*)$
          windowrule=float,title:^(Open Folder)(.*)$
          windowrule=float,title:^(Save As)(.*)$
          windowrule=float,title:^(Library)(.*)$ 
          windowrule=nofocus,title:^(.*)(mvi)$
          
          ######## Layer rules ########
          # layerrule = blur, gtk-layer-shell
          # layerrule = noanim, eww
          layerrule = blur, eww
          layerrule = ignorealpha 0.8, eww
          # layerrule = noanim, noanim
          # layerrule = blur, noanim
          layerrule = blur, powermenu
          layerrule = blur, gtk-layer-shell
          layerrule = ignorezero, gtk-layer-shell
          # layerrule = blur, launcher
          # layerrule = ignorealpha 0.5, launcher
          # layerrule = noanim, launcher
          layerrule = blur, notifications
          layerrule = ignorealpha 0.69, notifications
          windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
          windowrulev2 = noanim,class:^(xwaylandvideobridge)$
          windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
          windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$
          
          #################### It just works™ keybinds ###################
          # Volume
          bindl = ,XF86AudioMute, exec, pactl set-sink-mute @DEFAULT_SINK@ toggle
          bindle=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bindle=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          bindle = , XF86AudioRaiseVolume, exec, ~/.config/eww/scripts/volume osd &
          bindle = , XF86AudioLowerVolume, exec, ~/.config/eww/scripts/volume osd &
          bindl = , XF86AudioMute, exec, ~/.config/eww/scripts/volume osd &
          
          # Brightness
          bindle=, XF86MonBrightnessUp, exec, light -A 3 && ~/.config/eww/scripts/brightness osd &
          bindle=, XF86MonBrightnessDown, exec, light -U 3 && ~/.config/eww/scripts/brightness osd &
          
          ######################################## Keybinds ########################################
          # Apps: just normal apps
          bind = SUPER, Return, exec, foot
          bind = CONTROLSUPERSHIFTALT, E, exit, 
          
          # Apps: Settings and config
          bind = CONTROLSUPER, V, exec, pavucontrol 
          bind = CONTROLSHIFT, Escape, exec, gnome-system-monitor
          
          
          # Actions 
          # bind = SUPER, D, exec, tofi-drun | xargs hyprctl dispatch exec -- 
          # bind = SUPER, D, exec, ~/.config/eww/scripts/toggle-overview.sh
          bind = SUPER, Period, exec, pkill fuzzel || ~/.local/bin/fuzzel-emoji
          bind = CONTROLSUPER, Q, killactive,
          bind = CONTROLSUPER, Space, togglefloating, 
          bind = CONTROLSUPERSHIFT, Space, pin, 
          bind = CONTROLSHIFTSUPER, Q, exec, hyprctl kill
          bind = SUPER, A, exec, pkill fuzzel || ~/.local/bin/fuzzel-sys
          
          # Screenshot, Record, OCR (Optical Character Recognition), Color picker, Clipboard history
          bind = SUPERSHIFT, D, exec,~/.local/bin/rubyshot | wl-copy
          bind = CONTROLSUPERSHIFT, S, exec, grim -g "$(slurp)" - | swappy -f -
          bindl =,Print,exec,grim - | wl-copy | notify-send "Screenshot Capture"
          bind = SUPERSHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy
          bind = SUPERSHIFT, R, exec, ~/.local/bin/record-script.sh
          bind = CONTROLSUPERSHIFT, R, exec, ~/.local/bin/record-script.sh --sound
          bind = CONTROLSUPER, R, exec, ~/.local/bin/record-script-fullscreen.sh
          bind = SUPERSHIFT,S,exec,grim -g "$(slurp)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"
          bind = SUPERSHIFT,T,exec,grim -g "$(slurp)" "tmp.png" && tesseract "tmp.png" - | wl-copy && rm "tmp.png"
          bind = SUPERSHIFT, C, exec, hyprpicker -a
          bind = SUPER, V, exec, pkill fuzzel || cliphist list | fuzzel --no-fuzzy --prompt="   " --dmenu | cliphist decode | wl-copy
          
          # Media
          bind = SUPERSHIFT, N, exec, playerctl next || playerctl position `bc <<< "100 * $(playerctl metadata mpris:length) / 1000000 / 100"`
          bind = SUPERSHIFT, B, exec, playerctl previous
          bind = SUPERSHIFT, P, exec, playerctl play-pause
          
          #Lock screen  |  blur: --effect-blur=20x20
          # bind = SUPER, L, exec, gtklock
          bind = CONTROLSUPERSHIFTALT, L, exec, gtklock
          bind = CONTROLSUPERSHIFTALT, O, exec, pkill wlogout || wlogout -p layer-shell
          bind = CONTROLSUPERSHIFTALT, D, exec, systemctl poweroff
          bindl = CONTROLSUPERSHIFTALT, S, exec, systemctl suspend
          
          # App launcher
          # bindr = SUPER, SUPER_L, exec, ~/.config/eww/scripts/toggle-overview.sh --keypress &
          bind = SUPER, A, exec, ags -b hypr -t applauncher
          
          ################################# eww keybinds ################################
          bindr = CONTROLSUPERSHIFTALT, R, exec, ags quit; ags -b hypr
          bind = ControlSuper, W, exec, ~/.config/eww/scripts/switchwall
          bind = SUPER, I, exec, XDG_CURRENT_DESKTOP=GNOME gnome-control-center
          bind = Super, B, exec, ~/.config/eww/scripts/toggle-sideleft.sh &
          bind = Super, G, exec, ~/.config/eww/scripts/toggle-mixer.sh &
          bind = Super, Slash, exec, ~/.config/eww/scripts/toggle-cheatsheet.sh
          bind = Super, N, exec, ~/.config/eww/scripts/toggle-sideright.sh &
          
          ######### Cheat sheet #########
          bind = Super, Slash, submap, cheatsheet
          submap=cheatsheet
          bindl =,Print,exec,grim - | wl-copy
          bind = Super, Slash, exec, ~/.config/eww/scripts/toggle-cheatsheet.sh --close
          bind = , Escape, exec, ~/.config/eww/scripts/toggle-cheatsheet.sh --close
          bind = Super, Slash, submap, reset
          bind = , Escape, submap, reset
          submap=reset

          bind=Super, D, exec, ags -b hypr -t dashboard
          
          ######### Power Menu #########
          bind=CTRLAlt,Delete,exec, ags -b hypr -t powermenu
          bind=CTRLAlt,Delete,submap,powermenu
          submap=powermenu
          bindl =,Print,exec,grim - | wl-copy
          bind = SuperShift, S, exec, grim -g "$(slurp)" - | wl-copy
          bind=,Right,exec,VALUE=$(eww get powermenu_option); eww update powermenu_option=$(( VALUE % 3 == 2 || VALUE > 5 ? VALUE : VALUE + 1 ))
          bind=,Left,exec,VALUE=$(eww get powermenu_option); eww update powermenu_option=$(( VALUE % 3 == 0 || VALUE > 5 ? VALUE : VALUE - 1 ))
          bind=,Up,exec,VALUE=$(eww get powermenu_option); eww update powermenu_option=$(( VALUE > 2 ? VALUE - 3 : VALUE ))
          bind=,Down,exec,VALUE=$(eww get powermenu_option); eww update powermenu_option=$(( VALUE < 3 ? VALUE + 3 : 7 ))
          bind=,Return,exec,eval $(eww get POWERMENU_COMMANDS | gojq -r ".[$(eww get powermenu_option)]")
          bind=,Space,exec,eval $(eww get POWERMENU_COMMANDS | gojq -r ".[$(eww get powermenu_option)]")
          bind=,Grave,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[0]") && eww update powermenu_option=0
          bind=,1,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[1]") && eww update powermenu_option=0
          bind=,2,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[2]") && eww update powermenu_option=0
          bind=,3,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[3]") && eww update powermenu_option=0
          bind=,4,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[4]") && eww update powermenu_option=0
          bind=,4,exec,eval $(eww get POWERMENU_QUICKLAUNCHES | gojq -r ".[5]") && eww update powermenu_option=0
          bind=CTRLAlt,Delete,exec, eww close powermenu && eww update powermenu_option=0 
          bind=,Escape,exec, eww close powermenu && eww update powermenu_option=0
          bind=,Space,exec, eww close powermenu && eww update powermenu_option=0
          bind=,Return,exec, eww close powermenu && eww update powermenu_option=0
          bindr=Control,Control_R,exec, eww close powermenu && eww update powermenu_option=0
          bind=CTRLAlt,Delete,submap,reset
          bind=,Escape,submap,reset 
          bind=,Space,submap,reset 
          bind=,Return,submap,reset 
          bindr = Control, Control_R, submap, reset
          bind = ControlSuper, R, exec, hyprctl dispatch submap reset; pkill eww; pkill bash; pkill notify-receive; eww daemon && eww open bar && eww open bgdecor &
          submap=reset
          #############################
          
          ############################ Keybinds for Hyprland ############################
          # Swap windows
          bind = SUPERSHIFT, H, movewindow, l
          bind = SUPERSHIFT, L, movewindow, r
          bind = SUPERSHIFT, K, movewindow, u
          bind = SUPERSHIFT, J, movewindow, d
          # Move focus
          bind = SUPER, H, movefocus, l
          bind = SUPER, L, movefocus, r
          bind = SUPER, K, movefocus, u
          bind = SUPER, J, movefocus, d
          
          # Workspace, window, tab switch with keyboard
          bind = CONTROLSUPER, right, workspace, +1
          bind = CONTROLSUPER, left, workspace, -1
          bind = CONTROLSUPER, BracketLeft, workspace, -1
          bind = CONTROLSUPER, BracketRight, workspace, +1
          bind = CONTROLSUPER, up, workspace, -5
          bind = CONTROLSUPER, down, workspace, +5
          bind = SUPER, Page_Down, workspace, +1
          bind = SUPER, Page_Up, workspace, -1
          bind = CONTROLSUPER, Page_Down, workspace, +1
          bind = CONTROLSUPER, Page_Up, workspace, -1
          bind = SUPERSHIFT, Page_Down, movetoworkspace, +1
          bind = SUPERSHIFT, Page_Up, movetoworkspace, -1
          bind = CONTROLSUPER, L, movetoworkspace, +1
          bind = CONTROLSUPER, H, movetoworkspace, -1
          bind = SUPERSHIFT, mouse_down, movetoworkspace, -1
          bind = SUPERSHIFT, mouse_up, movetoworkspace, +1
          
          # Window split ratio
          binde = SUPER, Minus, splitratio, -0.1
          binde = SUPER, Equal, splitratio, 0.1
          binde = SUPER, Semicolon, splitratio, -0.1
          binde = SUPER, Apostrophe, splitratio, 0.1
          
          # Fullscreen
          bind = SUPER, F, fullscreen, 1
          bind = SuperShift, F, fullscreen, 0
          bind = ControlSuper, F, fakefullscreen, 0
          
          # Switching
          bind = SUPER, 1, workspace, 1
          bind = SUPER, 2, workspace, 2
          bind = SUPER, 3, workspace, 3
          bind = SUPER, 4, workspace, 4
          bind = SUPER, 5, workspace, 5
          bind = SUPER, 6, workspace, 6
          bind = SUPER, 7, workspace, 7
          bind = SUPER, 8, workspace, 8
          bind = SUPER, 9, workspace, 9
          bind = SUPER, 0, workspace, 10
          bind = SUPER, S, togglespecialworkspace
          bind = SUPER, M, togglespecialworkspace, monitor
          bind = SUPER, W, togglespecialworkspace, windows
          bind = SUPER, E, togglespecialworkspace, evolution
          bind = SUPER, C, togglespecialworkspace, kdeconnect
          # bind = SUPER, Tab, cyclenext
          bind = SUPER, Tab, exec, ags -b hypr -t overview
          bind = SUPER, Tab, bringactivetotop,   # bring it to the top
          
          # Move window to workspace Control + Super + [0-9] 
          bind = CONTROLSUPER, 1, movetoworkspacesilent, 1
          bind = CONTROLSUPER, 2, movetoworkspacesilent, 2
          bind = CONTROLSUPER, 3, movetoworkspacesilent, 3
          bind = CONTROLSUPER, 4, movetoworkspacesilent, 4
          bind = CONTROLSUPER, 5, movetoworkspacesilent, 5
          bind = CONTROLSUPER, 6, movetoworkspacesilent, 6
          bind = CONTROLSUPER, 7, movetoworkspacesilent, 7
          bind = CONTROLSUPER, 8, movetoworkspacesilent, 8
          bind = CONTROLSUPER, 9, movetoworkspacesilent, 9
          bind = CONTROLSUPER, 0, movetoworkspacesilent, 10
          bind = CONTROLSHIFTSUPER, Up, movetoworkspacesilent, special
          bind = CONTROLSUPER, S, movetoworkspacesilent, special
          
          # Scroll through existing workspaces with (Control) + Super + scroll
          bind = SUPER, mouse_up, workspace, +1
          bind = SUPER, mouse_down, workspace, -1
          bind = CONTROLSUPER, mouse_up, workspace, +1
          bind = CONTROLSUPER, mouse_down, workspace, -1
          
          # Move/resize windows with Super + LMB/RMB and dragging
          bindm = SUPER, mouse:272, movewindow
          bindm = SUPER, mouse:273, resizewindow
          bindm = SUPER, mouse:274, movewindow
          bindm = SUPER, Z, movewindow
          bind = CONTROLSUPER, Backslash, resizeactive, exact 640 480
          
          '';

      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";
}
