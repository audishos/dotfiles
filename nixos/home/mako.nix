{
  services.mako = {
    enable = true;

    settings = {
      on-button-middle = "dismiss-all";

      default-timeout = 30;

      # Catppuccin macchiato green
      background-color = "#24273a";
      text-color = "#cad3f5";
      border-color = "#a6da95";
      progress-color = "over #363a4f";
      "urgency=high" = {
        border-color = "#f5a97f";
      };
    };
  };
}
