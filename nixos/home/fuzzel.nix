{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "${pkgs.kitty}/bin/kitty";
        layer = "overlay";
        font = "SpaceMono Nerd Font Propo:weight=bold:size=24";
      };
      colors = {
        # Catppuccin macchiato green
        # https://github.com/catppuccin/fuzzel/blob/main/themes/catppuccin-macchiato/green.ini
        background = "24273add";
        text = "cad3f5ff";
        prompt = "b8c0e0ff";
        placeholder = "8087a2ff";
        input = "cad3f5ff";
        match = "a6da95ff";
        selection = "5b6078ff";
        selection-text = "cad3f5ff";
        selection-match = "a6da95ff";
        counter = "8087a2ff";
        border = "a6da95ff";
      };
    };
  };

  home = {
    packages = with pkgs; [
      bemoji
      wtype
    ];

    sessionVariables.BEMOJI_PICKER_CMD = "fuzzel -d";
  };
}
