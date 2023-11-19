{ stdenv, fetchurl, makeDesktopItem, lib }:

stdenv.mkDerivation rec {
  pname = "jetbrains-toolbox";
  version = "2.1.0.18144";

  src = fetchurl {
    url = "https://download.jetbrains.com/toolbox/jetbrains-toolbox-${version}.tar.gz";
    sha256 = "533294d2b018458a1a1b8047cea29b4a809cef134fe50528841d029f0cafa438";
  };

  desktopItem = makeDesktopItem {
    name = "jetbrains-toolbox";
    exec = "jetbrains-toolbox";
    icon = "jetbrains-toolbox";
    desktopName = "JetBrains Toolbox";
    genericName = "IDE Toolbox";
    categories = "Development;IDE;";
    mimeType = "application/x-toolbox-project;";
  };

  installPhase = ''
    mkdir -p $out/bin
    cp jetbrains-toolbox-${version}/jetbrains-toolbox $out/bin/
    mkdir -p $out/share/applications
    cp ${desktopItem}/share/applications/* $out/share/applications/
  '';

  meta = with lib; {
    description = "JetBrains Toolbox App";
    homepage = "https://www.jetbrains.com/toolbox-app/";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}

