{config, ...}: {
  programs.kitty = {
    enable = true;
  };

  xdg.configFile = let
    kittyConfigDir = "${config.home.homeDirectory}/code/dotfiles/dot_config/kitty";
  in {
    "kitty/kitty.conf".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/kitty.conf";
    "kitty/colors.conf".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/colors.conf";
    "kitty/scroll_mark.py".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/scroll_mark.py";
    "kitty/search.py".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/search.py";
    "kitty/pass_keys.py".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/pass_keys.py";
    "kitty/get_layout.py".source = config.lib.file.mkOutOfStoreSymlink "${kittyConfigDir}/get_layout.py";
  };
}
