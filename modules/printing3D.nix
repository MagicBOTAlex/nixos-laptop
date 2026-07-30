{ pkgs, fetchurl, ... }:
let
  orcaLogo = pkgs.fetchurl {
    url =
      "https://raw.githubusercontent.com/SoftFever/OrcaSlicer/main/resources/images/OrcaSlicer.png";
    sha256 = "02438fvggqsglxgpc4pvyjdr0la51j0ak99g8lz7b3a8hqdg3wpw";
  };
  orcaSlicerDesktopItem = pkgs.makeDesktopItem {
    name = "orca-slicer-dri";
    desktopName = "OrcaSlicer (DRI)";
    genericName = "3D Printing Software";
    icon = orcaLogo;
    exec =
      "env __GLX_VENDOR_LIBRARY_NAME=mesa __EGL_VENDOR_LIBRARY_FILENAMES=/run/opengl-driver/share/glvnd/egl_vendor.d/50_mesa.json MESA_LOADER_DRIVER_OVERRIDE=zink GALLIUM_DRIVER=zink WEBKIT_DISABLE_DMABUF_RENDERER=1  ${pkgs.orca-slicer}/bin/orca-slicer %U";
    terminal = false;
    type = "Application";
    mimeTypes = [
      "model/stl"
      "model/3mf"
      "application/vnd.ms-3mfdocument"
      "application/prs.wavefront-obj"
      "application/x-amf"
      "x-scheme-handler/orcaslicer"
    ];
    categories = [ "Graphics" "3DGraphics" "Engineering" ];
    keywords = [
      "3D"
      "Printing"
      "Slicer"
      "slice"
      "3D"
      "printer"
      "convert"
      "gcode"
      "stl"
      "obj"
      "amf"
      "SLA"
    ];
    startupNotify = false;
    startupWMClass = "orca-slicer";
  };

  mimeappsListContent = ''
    [Default Applications]
    model/stl=orca-slicer-dri.desktop;
    model/3mf=orca-slicer-dri.desktop;
    application/vnd.ms-3mfdocument=orca-slicer-dri.desktop;
    application/prs.wavefront-obj=orca-slicer-dri.desktop;
    application/x-amf=orca-slicer-dri.desktop;

    [Added Associations]
    model/stl=orca-slicer-dri.desktop;
    model/3mf=orca-slicer-dri.desktop;
    application/vnd.ms-3mfdocument=orca-slicer-dri.desktop;
    application/prs.wavefront-obj=orca-slicer-dri.desktop;
    application/x-amf=orca-slicer-dri.desktop;
  '';

  orcaSlicerMimeappsList =
    pkgs.writeText "orca-slicer-mimeapps.list" mimeappsListContent;


  freecadAppImageSrc = pkgs.fetchurl {
    url = "https://github.com/FreeCAD/FreeCAD/releases/download/1.1rc2/FreeCAD_1.1rc2-Linux-x86_64-py311.AppImage";
    sha256 = "sha256-xyYgbpnvcofS/zp+wDa3q87KLrBAq/PXjelGl4mHYww=";
  };

  freecadAppImage = pkgs.stdenvNoCC.mkDerivation {
    pname = "freecad-weekly-appimage";
    version = "2025.11.05";
    src = freecadAppImageSrc;
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/opt/freecad-weekly
      cp "$src" "$out/opt/freecad-weekly/FreeCAD_weekly-2025.11.05-Linux-x86_64-py311.AppImage"
      chmod +x "$out/opt/freecad-weekly/FreeCAD_weekly-2025.11.05-Linux-x86_64-py311.AppImage"
    '';
  };

  craftingTable = pkgs.fetchurl {
    name = "CraftingTable.png";
    url = "https://deprived.dev/assets/zhen/nixos/CraftingTable.png";
    hash = "sha256-7665bl6HOBBp32ixgiS10wMBR3xBjNv6JK/Lmag0BwU=";
  };

  freecadWrapper = pkgs.writeShellScriptBin "freecad-weekly" ''
    exec ${pkgs.appimage-run}/bin/appimage-run \
      ${freecadAppImage}/opt/freecad-weekly/FreeCAD_weekly-2025.11.05-Linux-x86_64-py311.AppImage "$@"
  '';

  freecadDesktop = pkgs.makeDesktopItem {
    name = "freecad-weekly";
    desktopName = "FreeCAD";
    comment = "FreeCAD 1.1 weekly preview (2025-11-05)";
    exec = "${freecadWrapper}/bin/freecad-weekly";
    icon = "${craftingTable}";
    categories = [
      "Graphics"
      "3DGraphics"
      "Engineering"
    ];
    terminal = false;
  };

in
{
  environment.systemPackages = [
    # pkgs.freecad-wayland
    # (pkgs.callPackage ./submodules/orca.nix { })
    # pkgs.orca-slicer
    freecadDesktop
    orcaSlicerDesktopItem
    (pkgs.writeTextDir "share/mime/packages/freecad.xml" ''
      <?xml version="1.0" encoding="UTF-8"?>
      <mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">
        <mime-type type="application/x-freecad">
          <comment>FreeCAD Document</comment>
          <glob pattern="*.FCStd" priority="100"/>
          <sub-class-of type="application/zip"/>
        </mime-type>
      </mime-info>
    '')

  ];

  environment.etc."xdg/mimeapps.list".source = orcaSlicerMimeappsList;
  environment.etc."xdg/mimeapps.list".mode = "0644";
}

