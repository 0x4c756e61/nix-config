{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    (config.lib.nixGL.wrap pods)
    (config.lib.nixGL.wrap gram)
    nix-output-monitor
    xh
  ];
  programs.helix.enable = true;

}
