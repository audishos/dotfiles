
{ config, lib, pkgs, neovimConfig, ... }:
let
  calibreLibcryptoPatch = pkgs.calibre.overrideAttrs
    (attrs: {
      preFixup = (
        builtins.replaceStrings
          [
            ''
              --prefix PYTHONPATH : $PYTHONPATH \
            ''
          ]
          [
            ''
              --prefix LD_LIBRARY_PATH : ${pkgs.openssl.out}/lib:${pkgs.udisks.out} \
              --prefix PYTHONPATH : $PYTHONPATH \
            ''
          ]
          attrs.preFixup
      );
    });
in
{
  home.packages = with pkgs; [
    calibreLibcryptoPatch
  ];
}
