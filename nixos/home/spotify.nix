{pkgs, ...}: {
  programs = {
    spotify-player = {
      enable = true;

      settings = {
        login_redirect_uri = "http://127.0.0.1:8989/login";
        client_id = "cdf763f761f241858dbaa7cf4ebf1d3b";
        device = {
          volume = 100;
          normalization = true;
        };
      };
    };
  };

  home.packages = with pkgs; [
    spot
  ];
}
