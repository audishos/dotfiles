{pkgs, ...}: {
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
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
      (nerdfonts.override {
        fonts = ["FiraCode" "FantasqueSansMono" "JetBrainsMono" "SpaceMono"];
      })
    ];

    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Source Han Serif"];
      sansSerif = ["Noto Sans" "Source Han Sans"];
    };
  };
}
