# I wasn't able to get this working correctly so stashing for later
# Current issues:
# 1. It takes a long time to load
# 2. Sway doesn't start automatically upon login
{ pkgs, ... }:
{
  environment.etc."greetd/sway-config".text = ''
    exec "${pkgs.greetd.regreet}/bin/regreet; ${pkgs.sway}/bin/swaymsg exit"
    include ~/.config/sway/config
  '';

  services.greetd = {
    enable = true;
    settings = {
      default_session.command = "${pkgs.sway}/bin/sway --config /etc/greetd/sway-config";
    };
  };

  programs.regreet.enable = true;

  security.pam.services.greetd.enableGnomeKeyring = true;
}
