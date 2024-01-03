# Add your reusable NixOS modules to this directory, on their own file (https://nixos.wiki/wiki/Module).
# These should be stuff you would like to share with others, not your personal configurations.
{
  # List your module files here
  # my-module = import ./my-module.nix;
  interception-tools = import ./interception-tools.nix;
  firewall = import ./firewall.nix;
  virt = import ./virt.nix;
  docker = import ./docker.nix;
  systemd-boot = import ./systemd-boot.nix;
  wsl = import ./wsl.nix;
}
