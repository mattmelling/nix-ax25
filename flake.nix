{
  description = "Linux AX.25 tools";
  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        overlays = [
          self.overlay
        ];
      };
    in {
      overlay = final: prev: {
        libax25 = prev.callPackage ./pkgs/libax25.nix { };
        ax25-tools = prev.callPackage ./pkgs/ax25-tools.nix { };
        ax25-apps = prev.callPackage ./pkgs/ax25-apps.nix { };
      };
      nixosModules.ax25 = {
        imports = [ ./module.nix ];
        nixpkgs.overlays = [
          self.overlay
        ];
      };
    };
}
