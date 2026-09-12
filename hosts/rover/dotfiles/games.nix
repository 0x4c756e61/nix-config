{
  config,
  pkgs,
  ...
}:
{

  home.packages = with pkgs; [
    (config.lib.nixGL.wrap steam)
    (config.lib.nixGL.wrap heroic)
    prismlauncher

    qt6.qt5compat
    kdePackages.breeze # Necessary for prism to use the breeze theme
    getopt # forkprince's twintaillauncher doesn't come with getopt out of the box, but the launcher requires it to work
    nur.repos.forkprince.twintaillauncher
    protonup-qt
  ];
}
