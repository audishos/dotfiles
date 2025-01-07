{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      atkinson-hyperlegible
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
      nerd-fonts.fira-code
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.space-mono
    ];

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif"];
      sansSerif = ["Noto Sans" "Source Han Sans"];
    };
  };
}
