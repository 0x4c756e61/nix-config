{ config, ... }:
{
  home.file."${config.xdg.configHome}/fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/hosts/rover/fastfetch/";
    recursive = true;
  };
}
