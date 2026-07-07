{ config, ... }:
{
  home.file."${config.xdg.configHome}/git" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/hosts/rover/dotfiles/git/";
    recursive = true;
  };
}
