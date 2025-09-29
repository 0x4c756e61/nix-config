{
  nixgl,
  config,
  pkgs,
  forgejo-cli,
  ...
}:

{
  home.username = "luna";
  home.homeDirectory = "/home/luna";
  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
  nixGL.packages = nixgl.packages;
  nixGL.defaultWrapper = "mesa";
  targets.genericLinux.enable = true;

  imports = [
    ./dotfiles
  ];

  home.packages = with pkgs; [
    (config.lib.nixGL.wrap gimp3)
    (config.lib.nixGL.wrap pods)
    (config.lib.nixGL.wrap dissent)
    (config.lib.nixGL.wrap fractal)

    # Fonts
    nerd-fonts.fira-code

    kdePackages.breeze
    prismlauncher

    # Dev tools
    nil # nix lsp
    nixd # other nix lsp
    forgejo-cli.packages.${pkgs.stdenv.hostPlatform.system}.default
    nix-output-monitor

    # Shell
    fish
    fishPlugins.fzf-fish
    fishPlugins.autopair
    fishPlugins.forgit
  ];


  # home.file = {
  #   # Chillpop service for lowfi since lofigirl's service is down
  #   ".local/share/lowfi/" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/lowfi";
  #     recursive = true;
  #   };

  #   ".config/ghostty/" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/ghostty/";
  #     recursive = true;
  #   };

  #   ".config/starship.toml" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/starship.toml";
  #   };

  #   ".config/kanata/config.kbd" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/kanata/config.kbd";
  #   };

  #   ".config/mpv" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/mpv";
  #     recursive = true;
  #   };

  #   ".config/fastfetch" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/fastfetch";
  #     recursive = true;
  #   };

  #   ".config/fish" = {
  #     source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/fish";
  #     recursive = true;
  #   };

  # };

}
