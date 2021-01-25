{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  name = "ax25-apps";
  version = "0.0.8-rc5";
  src = fetchurl {
    url = "http://www.linux-ax25.org/pub/ax25-apps/ax25-apps-0.0.8-rc5.tar.gz";
    sha256 = "15ng4ld84m38nzm7mcvga9691ikj9q5sxk48k95b5ddr5hihwd1k";
  };
  buildInputs = with pkgs; [
    libax25
    ncurses
  ];
}
