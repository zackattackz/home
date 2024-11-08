{ lib, pkgs, displays, ... }:

with lib;

let
  fingerprint = {
    "eDP-1" = "00ffffffffffff0009e5590700000000011b0104952213780a24109759548e271e505400000001010101010101010101010101010101641b5677500013303020360058c21000001aa21756b950002d303020360058c21000001a000000fe003937473339814e5431355430300000000000004101940110000009010a202000cb";
  };
in
{
  "main" = {
    inherit fingerprint;
    config = {
      "HDMI-1".enable = false;
      "eDP-1" = displays.athena-main // { primary = true; };
    };
  };
}
