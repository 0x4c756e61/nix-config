{
  nixgl,
  config,
  pkgs,
  forgejo-cli,
  spicetify,
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
    spicetify.homeManagerModules.default
    vicinae.homeManagerModules.default
    zen-browser.homeModules.beta
    ./dotfiles # Submodule containing all my user non-nix configurations (except for spotify lol)
  ];

  home.packages = with pkgs; [
    # -- Imagery
    (config.lib.nixGL.wrap gimp3)
    # --

    # -- Audio and video
    (config.lib.nixGL.wrap mpv)
    qpwgraph
    (config.lib.nixGL.wrap easyeffects)
    # --

    # -- Chatting platforms
    (config.lib.nixGL.wrap signal-desktop)
    (config.lib.nixGL.wrap dissent)
    (config.lib.nixGL.wrap (
      discord.override {
        withMoonlight = true;
        # withOpenASAR = true;
        moonlight = moonlight.packages.${pkgs.stdenv.hostPlatform.system}.moonlight;
        desktopName = "moonlight";
        commandLineArgs = "--ozone-platform=wayland"; # Seems to be required on non-nixOS installations? Not sure since the package already appends this if NIXOS_WAYLAND is set
      }
    ))
    # --

    # -- NixGL wrappers I need when testing apps within a nix shell
    nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixGLIntel
    nixgl.packages.${pkgs.stdenv.hostPlatform.system}.nixVulkanIntel
    # --

    # -- Fonts
    maple-mono.NF # Very cute and cozy font, would recommend
    # --

    # -- QT related
    kdePackages.breeze # Necessary for prism to use the breeze theme
    # --

    # -- Gaming
    (config.lib.nixGL.wrap steam)
    prismlauncher
    # --

    # -- Stuff i use for development
    (config.lib.nixGL.wrap pods)
    forgejo-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
    nix-output-monitor
    # --

    # -- System monitoring
    btop-rocm
    dysk
    # --

    # -- extras
    (config.lib.nixGL.wrap monero-gui)
    # --

  ];

  # Free and open source Raycast reimplementation
  services.vicinae = {
    enable = true;
    autoStart = true;
  };

  # Automatically set and unset environments when switching directory
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv.enable = true;
  };

  # Zen beta, best firefox fork
  programs.zen-browser = {
    enable = true;
    package = (config.lib.nixGL.wrap zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta);
    extraPrefsFiles = [ # in theory, this should be installing fx-autoconfig and allow Sine/Cosine to work, but it does not
      (builtins.fetchurl {
        url = "https://raw.githubusercontent.com/MrOtherGuy/fx-autoconfig/master/program/config.js";
        sha256 = "1mx679fbc4d9x4bnqajqx5a95y1lfasvf90pbqkh9sm3ch945p40";
      })
    ];
  };

  warnings = ["Check if there was any progress regarding zen-flake support for Sine"];

}
