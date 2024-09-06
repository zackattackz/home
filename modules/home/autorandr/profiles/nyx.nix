{ lib, pkgs, displays, ... }:

with lib;

let
  fingerprint = {
    "DP-0" = "00ffffffffffff001e6d5677b25f07000a1f0104b5522278fea105a9564ba4250f5054210800d1c061400101010101010101010101014ed470a0d0a0465030203a00345a3100001a000000fd0030641e9737000a202020202020000000fc004c472048445220575148440a20000000ff003131304e54445645373235300a011e02031f7423090707830100004410040301e2006ae305c000e606050152525e1ab370a0d0a03b5030203a00345a3100001ae77c70a0d0a0295030203a00345a3100001a9d6770a0d0a0225030203a00345a3100001a00000000000000000000000000000000000000000000000000000000000000000000000000000000000013";
    "HDMI-0" = "00ffffffffffff004c2d050c010600012a180103808e50780a23ada4544d99260f474abdef80714f81c0810081809500a9c0b300010108e80030f2705a80b0588a00501d7400001e023a801871382d40582c4500501d7400001e000000fd00184b0f873c000a202020202020000000fc0053414d53554e470a20202020200118020352f15761101f041305142021225d5e5f606566626364071603122309070783010000e2000fe305c00076030c004000b83c21d0880102030401403fff5060809067d85dc401788003e3060501e30f01e0011d80d0721c1620102c2580501d7400009e662156aa51001e30468f3300501d7400001e000000000000000000ef";
  };
  audio-profiles = {
    "main" = {
      "alsa_card.pci-0000_01_00.1" = "output:hdmi-stereo-extra1";
    };
    "tv" = {
      "alsa_card.pci-0000_01_00.1" = "output:hdmi-stereo";
    };
  };
  makeHook = profile: hooks: strings.concatLines (map (f: f profile) hooks);
  set-card-profile = card: profile: "${pkgs.pulseaudio}/bin/pactl set-card-profile ${card} ${profile}";
  change-audio-hook = profile: attrsets.foldlAttrs
    (acc: card: profile: "${acc}\n" + (set-card-profile card profile))
    ""
    audio-profiles.${profile};
in
{
  "main" = {
    inherit fingerprint;
    config = {
      "HDMI-0".enable = false;
      "DVI-D-0".enable = false;
      "DP-1".enable = false;
      "DP-0" = displays.lg-wide // { primary = true; };
    };
    hooks.postswitch = makeHook "main" [ change-audio-hook ];
  };
  "tv" = {
    inherit fingerprint;
    config = {
      "DP-0".enable = false;
      "DVI-D-0".enable = false;
      "DP-1".enable = false;
      "HDMI-0" = displays.living-tv // { primary = true; };
    };
    hooks.postswitch = makeHook "tv" [ change-audio-hook ];
  };
}
