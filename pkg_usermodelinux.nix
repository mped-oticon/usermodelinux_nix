{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "linux-kernel";
  version = "6.10.6";

  src = pkgs.fetchurl {
    url = "https://mirrors.edge.kernel.org/pub/linux/kernel/v6.x/linux-${version}.tar.xz";
    sha256 = "1ldkf2h7ccwq2hdngxjzp96qd4vlmy3z2y8fcrsr6ngqfidhvmg0";
  };

  nativeBuildInputs = with pkgs; [ gnused flex bison bc wget ripgrep gcc ];

  buildInputs = with pkgs; [ ];

  preConfigure = ''
    tar xf $src
    cd linux-${version}

    # Replace /bin/bash with /usr/bin/env bash using ripgrep and sed
    sed -i 's@/bin/bash@/usr/bin/env bash@g' $(rg -l /bin/bash)
  '';

  buildPhase = ''
    make ARCH=um defconfig
    make ARCH=um -j20
  '';

  installPhase = ''
    mkdir -p $out
    cp -r . $out/bin
  '';

  meta = with pkgs.lib; {
    description = "Linux Kernel";
    homepage = "https://www.kernel.org/";
  };
}

