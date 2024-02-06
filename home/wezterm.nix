{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}

      config.color_scheme = 'Catppuccin Mocha (Gogh)'
      config.font = wezterm.font 'Fira Code Nerd Font'
      config.window_background_opacity = 0.8

      return config
    '';
  };
}
