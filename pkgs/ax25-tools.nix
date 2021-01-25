{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  name = "ax25-tools";
  version = "0.0.10-rc5";
  src = fetchurl {
    url = "http://www.linux-ax25.org/pub/ax25-tools/ax25-tools-0.0.10-rc5.tar.gz";
    sha256 = "01ma6q5ij4f1p0jdbglkzhh8mia6k96ca3v3angwnvd8b25wpacj";
  };
  buildInputs = [
    libax25
  ];
  installPhase = ''
    mkdir -p $out/etc/ax25
    make install
  '';
}
