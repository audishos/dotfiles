{ pkgs, ... }:
{
  programs = {
    spotify-player = {
      enable = true;
      package = pkgs.spotify-player.override { withAudioBackend = "pulseaudio"; };

      settings = {
        client_id = "cdf763f761f241858dbaa7cf4ebf1d3b";
      };
    };
  };

  home.packages = with pkgs; [
    spot
  ];
}
