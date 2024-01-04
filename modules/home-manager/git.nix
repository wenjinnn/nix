{
  # git
  programs.git = {
    enable = true;
    userName = "wenjin";
    userEmail = "hewenjin94@outlook.com";
    extraConfig = {
      color.ui = true;
      credential.helper = "store";
      github.user = "wenjinnn";
      push.autoSetupRemote = true;
    };
  };
}
