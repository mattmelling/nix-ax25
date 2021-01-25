{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.ax25;
  portOpts = { name, ... }: {
    options = {
      callsign = mkOption {
        type = types.str;
        description = "Callsign used for the port, including SSID.";
        example = literalExample "2E0YML-1";
      };
      speed = mkOption {
        type = types.int;
        description = "Port baud rate";
        example = literalExample 4800;
      };
      paclen = mkOption {
        type = types.int;
        description = "Packet length";
        example = literalExample 256;
      };
      window = mkOption {
        type = types.int;
        description = "Port window size";
        example = literalExample 2;
      };
      description = mkOption {
        type = types.str;
        description = "Description of the port";
        example = literalExample "Direwolf software modem";
      };
    };
  };
in
{
  options = {
    ax25 = {
      enable = lib.mkEnableOption "ax25";
      ports = lib.mkOption {
        default = { };
        type = with types; attrsOf (submodule portOpts);
        example = {
          direwolf = {
            callsign = "2E0YML-1";
            speed = 4800;
            paclen = 256;
            window = 2;
            description = "direwolf software modem";
          };
        };
      };
    };
  };
  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        ax25-tools
        ax25-apps
      ];
      etc.axports.text = let
        ports = map (port: with port; "${name}   ${callsign}    ${toString speed}    ${toString paclen}    ${toString window}    ${description}")
          (mapAttrsToList (name: port: {
            inherit name;
            inherit (port) callsign speed paclen window description;
          }) cfg.ports);
      in (concatStringsSep "\n" ports) + "\n";
    };
  };
}
