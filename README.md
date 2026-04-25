# apm-overlay

Nix flake packaging [Microsoft APM CLI](https://microsoft.github.io/apm/) and its Python dependencies for NixOS and nix-darwin.

## Packages

| Package | Version |
|---------|---------|
| `apm-cli` | 0.9.2 |
| `azure-ai-inference` | 1.0.0b9 |
| `llm-github-models` | 0.18.0 |

## Usage

### Run without installing

```sh
nix run github:satomi-1224/apm-overlay
```

### nix profile

```sh
nix profile install github:satomi-1224/apm-overlay
```

### NixOS / nix-darwin (flake overlay)

```nix
{
  inputs.apm-overlay.url = "github:satomi-1224/apm-overlay";

  outputs = { nixpkgs, apm-overlay, ... }: {
    nixosConfigurations.my-host = nixpkgs.lib.nixosSystem {
      modules = [
        { nixpkgs.overlays = [ apm-overlay.overlays.default ]; }
        ({ pkgs, ... }: { environment.systemPackages = [ pkgs.apm-cli ]; })
      ];
    };
  };
}
```

## License

MIT
