{
  description = "Nix overlay for Microsoft APM CLI";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;

      mkPkgs =
        system:
        (import nixpkgs { inherit system; }).extend (final: prev: {
          python3 = prev.python3.override {
            packageOverrides = pyFinal: pyPrev: {
              azure-ai-inference = pyFinal.callPackage ./packages/azure-ai-inference.nix { };
              llm-github-models = pyFinal.callPackage ./packages/llm-github-models.nix { };
            };
          };
        });
    in
    {
      packages = forAllSystems (system: {
        apm-cli =
          let
            pkgs = mkPkgs system;
          in
          pkgs.python3.pkgs.callPackage ./packages/apm-cli.nix { };
        default = self.packages.${system}.apm-cli;
      });

      overlays.default = _final: prev: {
        apm-cli = self.packages.${prev.stdenv.hostPlatform.system}.apm-cli;
      };
    };
}
