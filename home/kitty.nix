{
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    theme = "Catppuccin-Mocha";

    settings = {
      background_opacity = "0.8";
      enabled_layouts = "tall:bias=70;full_size=1;mirrored=false, all";
    };
  };
}
