{
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local config = {}

      config.color_scheme = 'Catppuccin Mocha (Gogh)'
      config.font = wezterm.font_with_fallback {
        'Fira Code Nerd Font',
        'noto-fonts',
        'noto-fonts-cjk-sans',
        'noto-fonts-emoji',
        'Symbola',
        'font-awesome',
        'source-han-sans',
        'source-han-sans-japanese',
        'source-han-serif-japanese',
      }
      config.window_background_opacity = 0.8

      return config
    '';
  };
}
