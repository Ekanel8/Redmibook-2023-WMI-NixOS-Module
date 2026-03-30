{ config, pkgs, lib, ... }:

let
  cfg = config.services.redmibook.wmi;

  wmiDrv = pkgs.stdenv.mkDerivation rec {
    pname = "redmibook_wmi";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Ekanel8";
      repo = "Redmibook-2023-WMI-NixOS-Module";
      rev = "main";
      sha256 = "";
    };

    buildInputs = [
      config.boot.kernelPackages.kernel.dev
      pkgs.gnumake
      pkgs.gcc
    ];

    buildPhase = ''
      make -C ${config.boot.kernelPackages.kernel.dev}/lib/modules/${config.boot.kernelPackages.kernel.dev.modDirVersion}/build \
        M=$PWD/drivers/redmibook_wmi modules
    '';

    installPhase = ''
      mkdir -p $out/lib/modules/${config.boot.kernelPackages.kernel.dev.modDirVersion}/extra
      cp drivers/redmibook_wmi/redmibook_wmi.ko \
         $out/lib/modules/${config.boot.kernelPackages.kernel.dev.modDirVersion}/extra/
    '';
  };
in
{
  options.services.redmibook.wmi.enable = lib.mkOption {
    type = lib.types.bool;
    default = true;
    description = "Enable Redmibook WMI kernel module.";
  };

  config = lib.mkIf cfg.enable {
    boot.extraModulePackages = [ wmiDrv ];
    boot.kernelModules = [ "redmibook_wmi" ];
    environment.systemPackages = [ wmiDrv ];
  };
}
