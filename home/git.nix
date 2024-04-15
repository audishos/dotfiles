{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "audishos";
    userEmail = "audisho.sada@gmail.com";
  };
}
