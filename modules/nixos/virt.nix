{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    quickemu
    quickgui
  ];
  # virtualisation
  programs.virt-manager.enable = true;    
  virtualisation.libvirtd.enable = true;
}
