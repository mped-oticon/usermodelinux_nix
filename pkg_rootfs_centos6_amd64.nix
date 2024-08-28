{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "centos6-root-fs";
  version = "6.x";

  src = pkgs.fetchurl {
    url = "http://fs.devloop.org.uk/filesystems/CentOS-6.x/CentOS6.x-AMD64-root_fs.bz2";
    sha256 = "0grx8x28kr98vcqf498kzmlprnqx261rwwd1fr6j406s5qhx2q8r";
  };

  # Disable the default unpack phase as it does not handle bz2 files
  dontUnpack = true;

  dontBuild = true;

  nativeBuildInputs = with pkgs; [ bzip2 ];

  installPhase = ''
    mkdir -p $out
    bzip2 -d -c $src > $out/root_fs.img
  '';

  meta = with pkgs.lib; {
    description = "CentOS 6.x AMD64 Root Filesystem";
    homepage = "http://fs.devloop.org.uk/";
  };
}
