{ config, ... }:
{
  home.file."${config.xdg.configHome}/ghostty" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/hosts/rover/dotfiles/ghostty/";
    recursive = true;
  };
}
