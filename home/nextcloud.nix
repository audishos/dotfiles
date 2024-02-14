{ lib, pkgs, ... }:
{
  # Ensures nextcloud-client system tray is "mounted"
  systemd.user.services.nextcloud-client = {
    Service.ExecStartPre = lib.mkForce "${pkgs.coreutils}/bin/sleep 5";
    Unit = {
      After = lib.mkForce [ "graphical-session.target" ];
      PartOf = lib.mkForce [ ];
    };
  };

  services.nextcloud-client.enable = true;

  # the above is not executable via cli or launcher
  # adding the package fixes this
  home.packages = with pkgs; [ nextcloud-client ];
}
