{ lib
, fetchFromGitHub
, python3Packages
, zackattackz
, wrapGAppsNoGuiHook
, ...
}:

python3Packages.buildPythonPackage {
  pname = "rotification";
  version = "1.2.2";

  src = fetchFromGitHub {
    owner = "regolith-linux";
    repo = "regolith-rofication";
    rev = "master";
    hash = "sha256-9UKKENrEicQKBWLczQFHmfsa9yxoKTGd+dTDZ/YdkS0=";
  };

  build-system = [
    python3Packages.setuptools
  ];

  nativeBuildInputs = [ wrapGAppsNoGuiHook ];

  dependencies = [
    python3Packages.setuptools
    python3Packages.pygobject3
    python3Packages.dbus-python
  ];

  meta = {
    description = "Notification system that provides a Rofi front-end";
    homepage = "https://github.com/regolith-linux/regolith-rofication";
    license = lib.licenses.mit;
    maintainers = [ zackattackz ];
  };
}