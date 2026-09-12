{ ... }:
{
  programs.aria2 = {
    enable = true;
    systemd.enable = true;
    settings = {
      enable-rpc = true;
      rpc-secret = "oarvgeruryoernrvieraorvfezvzererv432ezrgzerg";
      dir = "/home/luna/Downloads";
      split = 15;
      max-connection-per-server = 5;
      # rpc-listen-all = true;
    };
  };

  # Aria2 does not support running the RPC behind a seperate interface, as a workaround, we
  # forward packets coming from the tailnet port 6800 to our local 6800.
  # This avoids having to use rpc-listen-all, which would make aria2 listen on all interfaces, which is not desirable
  systemd.user.services.aria2-ts-tunel = {
    Unit = {
      Description = "Forwards port 6800 (Aria2) from tailscale interface to localhost.";
    };

    Service = {
      Type = "simple";
      ExecStart = "/usr/bin/tailscale serve --tcp=6800 tcp://localhost:6800";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
