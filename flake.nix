{
  description = "A RISC-V TestRIG Verification Engine based on QuickCheck";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" ] (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        hsPkgs = pkgs.haskell.packages.ghc94.override {
          overrides = _self: super: {
            mkDerivation =
              args:
              super.mkDerivation (
                args
                // {
                  doCheck = false;
                  doBenchmark = false;
                }
              );
            pretty-diff = pkgs.haskell.lib.doJailbreak super.pretty-diff;
          };
        };
      in
      {
        devShells.default = hsPkgs.shellFor {
          packages = hsPkgs: [
            (hsPkgs.callPackage ./default.nix { })
          ];
          nativeBuildInputs = [ pkgs.cabal-install ];
        };

        formatter = pkgs.nixfmt;

        packages = {
          default = self.packages.${system}.qcvengine;
          qcvengine = hsPkgs.callPackage ./default.nix { };
        };
      }
    );
}
