{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {

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
        src = ../../xdg/dotfiles;
        file = ".p10k.zsh";
      }
    ];
    initExtraFirst = ''
      export LANG=en_US.UTF-8
      if [[ -n "''${IS_NVIM_DAP_TOGGLETERM}" ]]; then
          return
      fi
      # TMUX
      if [ -x "$(command -v tmux)" ] && [ -n "''${DISPLAY}" ] && [ "''${TERM_PROGRAM}" != "vscode" ] && [ "''${XDG_SESSION_DESKTOP}" != "hyprland" ] && [ -z "''${TMUX}" ]; then
          tmux attach || tmux >/dev/null 2>&1
      fi
      '';
    initExtra = let proxyAddr = "http://127.0.0.1:7890"; in ''
      export GTK_IM_MODULE=fcitx
      export XMODIFIERS=@im=fcitx
      export QT_IM_MODULE=fcitx
      COMPLETION_WAITING_DOTS="true"
      bindkey '^ ' autosuggest-accept
      PROXY_ENV=(http_proxy ftp_proxy https_proxy all_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY ALL_PROXY)
      NO_PROXY_ENV=(no_proxy NO_PROXY)
      proxy_addr=${proxyAddr}
      no_proxy_addr=localhost,127.0.0.1,localaddress,.localdomain.com,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24,192.168.49.2/24

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
          echo "proxy addr is:"
          echo ''${proxy_addr}
          echo "no proxy addr is:"
          echo ''${no_proxy_addr}
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
              # proxy_addr="http://$user:$pass@ProxyServerAddress:Port"
              assignProxy $proxy_addr $no_proxy_addr
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

}
