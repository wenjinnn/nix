{
  services.xserver = {
    displayManager.gdm.enable = true;
    desktopManager.gnome = {
      enable = true;
      };
  };
  services.gnome.evolution-data-server = {
    enable = true;
  };
}
