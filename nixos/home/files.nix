{pkgs, ...}: {
  home.packages = with pkgs; [
    ffmpegthumbnailer
    kdePackages.dolphin
    kdePackages.dolphin-plugins
    kdePackages.ffmpegthumbs
    kdePackages.kdegraphics-mobipocket
    kdePackages.kio
  ];
}
