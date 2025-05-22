{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      atkinson-hyperlegible
      dina-font
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.hurmit
      nerd-fonts.jetbrains-mono
      nerd-fonts.space-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      proggyfonts
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif"];
      sansSerif = ["Noto Sans" "Source Han Sans"];
    };
  };
}
