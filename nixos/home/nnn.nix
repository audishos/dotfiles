{
  config,
  pkgs,
  nnnSrc,
  ...
}: let
  nnn = pkgs.nnn.override {
    withNerdIcons = true;
    withPcre = true;
  };
in {
  # terminal file manager
  # https://github.com/jarun/nnn
  programs = {
    nnn = {
      enable = true;
      package = nnn;
      plugins = {
        src = "${nnnSrc}/plugins";
        mappings = {
          p = "preview-tui";
        };
      };
    };
  };

  home = {
    sessionVariables.NNN_FIFO = "${config.home.homeDirectory}/.cache/nnn.fifo";
    shellAliases = {
      nnn = "${nnn}/bin/nnn -e";
      ls = "${nnn}/bin/nnn -e";
    };
  };
}
