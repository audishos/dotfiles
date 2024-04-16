{ config, ... }:
{
  programs.kitty = {
    enable = true;
  };

  xdg.configFile = {
    "kitty/kitty.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/code/dotfiles/dot_config/kitty/kitty.conf";
    };
  };
}
