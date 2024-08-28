{ pkgs ? import <nixpkgs> {} }:

let
  centosRootFs = import ./pkg_rootfs_centos6_amd64.nix { inherit pkgs; };
  userModeLinux = import ./pkg_usermodelinux.nix { inherit pkgs; };
in

pkgs.mkShell {
  buildInputs = [
    centosRootFs
    userModeLinux
  ];

  shellHook = ''
    # Nix store is read-only, and booting requires read-write - so copy
    cp ${centosRootFs}/root_fs.img ./root_fs.img
    chmod +rw ./root_fs.img

    # Only run for a bit, since terminal is taken over 
    timeout 60 ${userModeLinux}/bin/linux ubda=./root_fs.img mem=256m
  '';
}
