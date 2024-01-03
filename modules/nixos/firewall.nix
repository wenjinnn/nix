{
  networking.nftables.enable = true;
  networking.firewall = {
   enable = true;
   checkReversePath = "loose";
   trustedInterfaces = [ "tun*" ];
   allowedTCPPorts = [ 80 443 ];
   allowedUDPPortRanges = [
     { from = 4000; to = 4007; }
     { from = 8000; to = 9000; }
   ];
  };
}
