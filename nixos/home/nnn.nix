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
  homeDir = config.home.homeDirectory;
in {
  # terminal file manager
  # https://github.com/jarun/nnn
  programs = {
    nnn = {
      enable = true;
      package = nnn;
      plugins = {
        src = "${nnnSrc}/plugins";
      };
    };
  };

  home = {
    sessionVariables = {
      # File cache for things like preview
      NNN_FIFO = "${homeDir}/.cache/nnn.fifo";
      # Plugin mappings https://github.com/jarun/nnn/tree/master/plugins#configuration
      NNN_PLUG = "p:preview-tui";
      # Bookmarks https://github.com/jarun/nnn/wiki/Basic-use-cases#add-bookmarks
      NNN_BMS = "c:${homeDir}/code;d:${homeDir}/Downloads";
      # Handles moar archive types via bsd(tar)
      NNN_ARCHIVE = "\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$";
    };

    shellAliases = {
      nnn = "${nnn}/bin/nnn -e";
    };
  };
}
