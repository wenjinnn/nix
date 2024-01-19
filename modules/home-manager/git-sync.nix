{
  services.git-sync = {
    enable = true;
    repositories.archive = {
      path = "/home/wenjin/project/my/archive";
      uri = "git@github.com:wenjinnn/archive.git";
    };
  };
}

