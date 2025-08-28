{ lib, stdenv, fetchurl, unzip, autoPatchelfHook, makeWrapper, makeDesktopItem
, copyDesktopItems, dotnetCorePackages, icu, openssl, zlib, krb5, libX11, libICE
, libSM, fontconfig, libGL, vulkan-loader, alsa-lib }:

let
  vrcft-icon = fetchurl {
    url =
      "https://github.com/dfgHiatus/VRCFaceTracking.Avalonia/blob/main/src/VRCFaceTracking.Avalonia.Desktop/VRCFT-logo_128.png?raw=true";
    hash =
      "sha256:f7bd3f98d1938601c69bc94cd4634c01913b826943eaec26546ef62f25047599";
  };

  desktopItem = makeDesktopItem {
    name = "vrcft";
    exec = "vrcft";
    icon = "vrcft";
    desktopName = "VRCFaceTracking";
    comment = "VRChat Face Tracking Application";
    categories = [ "Game" "Utility" ];
    startupNotify = false;
  };

in stdenv.mkDerivation rec {
  pname = "vrcft";
  version = "1.1.0.0";

  src = fetchurl {
    url =
      "https://github.com/dfgHiatus/VRCFaceTracking.Avalonia/releases/download/v${version}/linux-x64_net8.0.zip";
    hash =
      "sha256:c92ce6dd66c30a10a4c32ee5dd164e18b9a39f0eeb5de9d83096ebbd3337b69f";
  };

  nativeBuildInputs = [ unzip autoPatchelfHook makeWrapper copyDesktopItems ];

  buildInputs = [
    dotnetCorePackages.runtime_8_0
    icu
    openssl
    zlib
    krb5
    libX11
    libICE
    libSM
    fontconfig
    libGL
    vulkan-loader
    alsa-lib
  ];

  desktopItems = [ desktopItem ];

  unpackPhase = ''
    runHook preUnpack
    unzip $src
    runHook postUnpack
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/vrcft
    mkdir -p $out/bin
    mkdir -p $out/share/icons/hicolor/128x128/apps

    # Copy all application files
    cp -r * $out/lib/vrcft/

    # Install icon
    cp ${vrcft-icon} $out/share/icons/hicolor/128x128/apps/vrcft.png

    # Make the main executable, well, executable
    chmod +x $out/lib/vrcft/VRCFaceTracking.Avalonia.Desktop

    # Create wrapper script
    makeWrapper $out/lib/vrcft/VRCFaceTracking.Avalonia.Desktop $out/bin/vrcft \
      --set DOTNET_SYSTEM_GLOBALIZATION_INVARIANT 0 \
      --prefix LD_LIBRARY_PATH : "${
        lib.makeLibraryPath buildInputs
      }:$out/lib/vrcft" \
      --chdir $out/lib/vrcft

    runHook postInstall
  '';

  meta = with lib; {
    description = "VRChat Face Tracking application for Avalonia";
    homepage = "https://github.com/dfgHiatus/VRCFaceTracking.Avalonia";
    license = licenses.mit; # Adjust based on actual license
    platforms = platforms.linux;
    maintainers = [ ]; # Add your name if you want
    mainProgram = "vrcft";
  };
}
