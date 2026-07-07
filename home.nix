{
  nixgl,
  config,
  pkgs,
  moonlight,
  vicinae,
  zen-browser,
  ...
}:
{
  home.username = "luna";
  home.homeDirectory = "/home/luna";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;

  # -- nixGL stuff
  targets.genericLinux.nixGL.packages = nixgl.packages;
  targets.genericLinux.nixGL.defaultWrapper = "mesa";
  targets.genericLinux.nixGL.vulkan.enable = true;
  # --

  # -- Config options
  targets.genericLinux.enable = true;
  fonts.fontconfig.enable = true; # Allow fontconfig to look for fonts in my user directory
  xdg.autostart.enable = true; # Necessary for apps to request to be autostarted, like keepassXC
  # --

  imports = [
    vicinae.homeManagerModules.default
    zen-browser.homeModules.beta
    ./dotfiles # Submodule containing all my user configurations
  ];

  home.packages = with pkgs; [
    # -- NixGL wrappers I need when testing apps within a nix shell
    nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLIntel
    nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixVulkanIntel
  ];
}
