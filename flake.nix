{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    conch = {
      url = "github:mibmo/conch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { conch, ... }:
    conch.load [
      "aarch64-darwin"
      "riscv64-linux"
      "x86_64-darwin"
      "x86_64-linux"
    ]
      ({ pkgs, ... }: {
        packages = with pkgs; [
          act
        ];
        aliases.run = "act --pull=false --secret GITHUB_TOKEN=$GITHUB_TOKEN --secret CACHIX_AUTH_TOKEN=$CACHIX_AUTH_TOKEN";
        shellHook = ''
          echo "For testing locally:"
          echo "  - set environment variable GITHUB_TOKEN to a PAT token"
          echo "  - set environment variable CACHIX_AUTH_TOKEN to an auth token"
          echo "A \`run\` alias is defined to run the action workflow locally"
        '';
      });
}
