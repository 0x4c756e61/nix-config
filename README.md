# Lyna's dotfiles
![Estrogen-shield]

---

Lyna's personal dotfiles, currently only a home-manager config.

> [!IMPORTANT]
> This configuration requires flakes, and the pipe-operator, so make sure they are enabled inside your nix config

## Disclaimer
Those aren't meant to be used by others as-is, and only serves as a reference.

--- 

## Structure
> ![note]
> Those dotfiles are currently made to run on *non* nixOS/nixdarwin systems, and thus uses nixGL to get graphical applications working.

### flake
The flake serves as the entrypoint of the dotfiles, currently all it does is fetch the various package "repos" (inputs), and patches nixpkgs to support nixgl.

In the future this flake will be able to support different hosts nixOS hosts, however as of now only the file structure is present to support this architecture.

### The dotfiles themselves
This is where the magic takes place, each files (or folder, refered to as *modules*) in the dotfiles directory is automatically imported at evaluation time to avoid writing paths by hand. 

Disabling a module can simply be done by either renaming the file as `something.old` or by adding `-ignore` to the filename.

## Building
Building can simply be achieved by running the following command `nom build ".#homeConfigurations.luna.activationPackage"` and later on activating the config with `./result/bin/home-manager-generation`

[Estrogen-shield]: https://cloud.bitfl0wer.de/public.php/dav/files/P4LW9dawZKwJEEZ
