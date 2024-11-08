{
  lg-wide = {
    crtc = 0;
    gamma = "1.099:1.0:0.909";
    mode = "3440x1440";
    position = "0x0";
    rate = "99.98";
    extraConfig = "x-prop-non_desktop 0";
  };
  living-tv = {
    crtc = 0;
    mode = "3840x2160";
    position = "0x0";
    rate = "60.00";
    extraConfig = "x-prop-non_desktop 0";
  };
  athena-main = {
    crtc = 0;
    mode = "1366x768";
    position = "0x0";
    rate = "60.00";
    extraConfig = ''
      x-prop-non_desktop 0
      x-prop-broadcast_rgb Automatic
      x-prop-colorspace Default
      x-prop-scaling_mode Full aspect
      x-prop-max_bpc 12
    '';
  };
}
