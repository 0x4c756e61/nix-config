{ config, ... }:
{
  home.file."${config.xdg.configHome}/starship.toml" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/home-manager/hosts/rover/starship/starship.toml";
  };
}
