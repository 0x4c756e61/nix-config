{
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [ languagetool ];

  systemd.user.services.languagetool = {
    Unit = {
      Description = "Languagetool HTTP server";
    };

    Service = {
      Type = "simple";
      PIDFile = "/run/language-tool.pid";
      Restart = "always";
      ExecStart = "/home/luna/.nix-profile/bin/languagetool-server";
      ExecReload = "/bin/kill -HUP $MAINPID";
      ExecStop = "/bin/kill -QUIT $MAINPID";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}
