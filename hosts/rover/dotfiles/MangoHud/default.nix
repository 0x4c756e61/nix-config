{ config, ... }:
{
  home.file."${config.xdg.configHome}/MangoHud" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/hosts/rover/dotfiles/MangoHud/";
    recursive = true;
  };
}
