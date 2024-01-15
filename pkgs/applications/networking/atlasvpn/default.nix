{ maintainers, ... }: { lib, stdenv, fetchurl, binutils, gnutar, ... }:
stdenv.mkDerivation rec {
  pname = "atlasvpn";
  version = "1.1.0";
  src = fetchurl {
    url = "https://repo.atlasvpn.com/debian/pool/main/a/atlasvpn/atlasvpn_${version}_amd64.deb";
    hash = "sha256-iKzluC9qga/8IJCGpdtIdsEHrfTk1q6nycjmCkx0gKg=";
  };
  meta = {
    description = "A vpn with free and paid options.";
    homepage = "https://atlasvpn.com/";
    maintainers = [ maintainers.zackattackz ];
    platforms = lib.platforms.all;
  };

  unpackPhase = ''
      runHook preUnpack
      ar x $src
      tar xf data.tar.xz
      runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/lib/systemd/system

    install -Dm755 usr/bin/atlasvpn $out/bin/atlasvpn
    install -Dm755 usr/sbin/atlasvpnd $out/bin/atlasvpnd
    install -Dm644 lib/systemd/system/atlasvpnd.service $out/lib/systemd/system/atlasvpnd.service
    install -Dm644 lib/systemd/system/atlasvpnd.socket $out/lib/systemd/system/atlasvpnd.socket

    runHook postInstall
  '';
}