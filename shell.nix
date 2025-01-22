{ pkgs ? import <nixpkgs> { } }:

with pkgs;
mkShell {
  name = "ustc-proposal";
  buildInputs = [
    typst
  ];
  shellHook = ''
    unset SOURCE_DATE_EPOCH
  '';
}
