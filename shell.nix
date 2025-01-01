{ pkgs ? import (builtins.fetchTarball {
    # NixOS/nixpkgs#237313 = ppenguin:refactor-platformio-fix-ide
    url = "https://github.com/ppenguin/nixpkgs/archive/refactor-platformio-fix-ide.tar.gz";
  }) {},
}:
let
  envname = "platformio-fhs";
  mypython = pkgs.python3.withPackages (ps: with ps; [ platformio ]);
in
(pkgs.buildFHSUserEnv {
  name = envname;
  targetPkgs = pkgs: (with pkgs; [
    platformio-core
    mypython
    openocd
  ]);
  # NixOS/nixpkgs#263201, NixOS/nixpkgs#262775, NixOS/nixpkgs#262080
  runScript = "env LD_LIBRARY_PATH= bash";
}).env