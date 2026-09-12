{
  config,
  pkgs,
  chipass,
  ...
}:
{
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap monero-gui)
    (config.lib.nixGL.wrap kdePackages.akregator)
    chipass.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
