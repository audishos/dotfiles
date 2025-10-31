{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      package = pkgs.gitFull;
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
