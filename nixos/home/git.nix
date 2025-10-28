{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      package = pkgs.gitAndTools.gitFull;
      settings.user = {
        name = "audishos";
        email = "audisho.sada@gmail.com";
      };
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
    };
  };
}
