{ primaryUser,inputs }:
{
  nix-homebrew = {
    enable = true;

    # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
    # Dreprecated: Macos 27 no longer use Rosetta
    enableRosetta = false;

    # User owning the Homebrew prefix
    user = "${primaryUser}";
    autoMigrate = true;

    taps = {
      "homebrew/homebrew-core" = inputs.homebrew-core;
      "homebrew/homebrew-cask" = inputs.homebrew-cask;

      "tinypkg/homebrew-tap" = inputs.homebrew-tap-tinypkg;
    };

    # Optional: Enable fully-declarative tap management
    #
    # With mutableTaps disabled, taps can no longer be added imperatively with `brew tap`.
    mutableTaps = false;
  };
}
