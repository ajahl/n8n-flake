{
  description = "n8n docker dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-darwin";
    pkgs = import nixpkgs { inherit system; };
  in {
    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        docker
        docker-compose
        colima
        git
      ];

      shellHook = ''
        echo "Starting Colima if not running..."
        colima start || true
      '';
    };
  };
}