[github-workflow]: https://github.com/mibmo/cacheit/actions/workflows/populate-cache.yaml

# Binary cache for [_everything_](#caches)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mibmo/cache-it/populate-cache.yaml?style=flat-square)][github-workflow]

An up-to-date binary cache for several projects.
Builds are generated nightly to ensure the latest version is always cached.

## System support
The binary caches try to have binaries for all supported platforms, but generally

- [x] `x86_64-linux`
- [x] `aarch64-linux`
- [x] `x86_64-darwin`
- [x] `aarch64-darwin`

## Caches
Unless noted otherwise, every cache has full support for the relevant project's supported systems.

- **[serokell/deploy-rs](https://github.com/serokell/deploy-rs)** -
    Multi-profile Nix-flake deploy tool.
    [master]
    ([cache](https://deploy-rs.cachix.org))
- **[famedly/conduit](https://gitlab.com/famedly/conduit)** -
    Simple, fast, reliable Matrix homeserver.
    [master, next]
    (**note**: only linux)
    ([cache](https://conduit.cachix.org))

## Usage
Substitute the relevant `CACHE_NAME` (e.g. `deploy-rs`) and `CACHE_KEY` (e.g. `deploy-rs.cachix.org-1:xfNobmiwF/vzvK1gpfediPwpdIP0rpDV2rYqx40zdSI=`) into the below snippets to use  the caches.

### Flake-based system
To use the binary cache for nixos systems configured via flake, first
add the cache as a substituter and then trust the public key.
```nix
nix.settings = {
  substituters = [ "https://CACHE_NAME.cachix.org" ];
  trusted-public-keys = [ "CACHE_KEY" ];
};
```

### Non-flake system
To use the binary cache, add it to your [`nix.conf`](https://nixos.org/manual/nix/stable/command-ref/conf-file.html).
```conf
extra-substituters = https://CACHE_NAME.cachix.org
extra-trusted-public-keys = CACHE_KEY
```

### Per-flake configuration
Flakes can suggest `nix.conf` changes when evaluated via the top-level `nixosConfig` attribute.
To add the cache for users of your flake, add the following to your flake
```nix
{
  input = { ... };
  outputs = { ... };
  nixConfig = {
    extra-substituters = [ "https://CACHE_NAME.cachix.org" ];
    extra-trusted-public-keys = [ "CACHE_KEY" ];
  };
}
```
