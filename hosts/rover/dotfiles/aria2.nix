{ ... }:
{
  programs.aria2 = {
    enable = true;
    systemd.enable = true;
    settings = {
      enable-rpc = true;
      rpc-secret = "oarvgeruryoernrvieraorvfezvzererv432ezrgzerg";
    };
  };
}
