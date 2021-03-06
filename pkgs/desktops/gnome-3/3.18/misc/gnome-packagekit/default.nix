{ stdenv, fetchurl, pkgconfig, intltool, gnome3, libxslt, packagekit
, fontconfig, libcanberra_gtk3, libnotify, wrapGAppsHook, dbus_glib, dbus_libs }:

stdenv.mkDerivation rec {
  name = "gnome-packagekit-${version}";
  version = "3.18.0";

  src = fetchurl {
    url = "mirror://gnome/sources/gnome-packagekit/3.18/${name}.tar.xz";
    sha256 = "0a7ww807b77yjf6l8s2ycpxx813lyncwaxq227jckphazpq65a50";
  };

  NIX_CFLAGS_COMPILE = "-I${dbus_glib.dev}/include/dbus-1.0 -I${dbus_libs.dev}/include/dbus-1.0";

  nativeBuildInputs = [ pkgconfig intltool wrapGAppsHook ];
  buildInputs = [ libxslt gnome3.gtk packagekit fontconfig
                  libcanberra_gtk3 libnotify dbus_glib dbus_libs ];

  meta = with stdenv.lib; {
    homepage = https://www.freedesktop.org/software/PackageKit/;
    platforms = platforms.linux;
    maintainers = gnome3.maintainers;
    license = licenses.gpl2;
    description = "Tools for installing software on the GNOME desktop using PackageKit";
  };
}
