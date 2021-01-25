{ pkgs, ... }:
with pkgs;
stdenv.mkDerivation rec {
  name = "libax25";
  version = "0.0.12-rc5";
  src = fetchurl {
    url = "http://www.linux-ax25.org/pub/libax25/libax25-0.0.12-rc5.tar.gz";
    sha256 = "1pr38g7r32c4lr6p0vakn5mpwxm6v45dhxgy6zybs7nfa0cpj5dz";
  };
  installPhase = ''
    mkdir -p $out/etc/ax25
    make install
  '';
}
