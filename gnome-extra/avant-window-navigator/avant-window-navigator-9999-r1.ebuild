# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EBZR_REPO_URI="lp:awn"
PYTHON_DEPEND="2:2.7"

inherit autotools bzr distutils gnome2 python

DESCRIPTION="Fully customizable dock for the Free desktop"
HOMEPAGE="https://launchpad.net/awn"
SRC_URI=""
LICENSE="GPL-2 LGPL-2.1 CCPL-Attribution-ShareAlike-3.0"

SLOT="0"
KEYWORDS=""
IUSE="doc gconf"

COMMON_DEPEND="
	dev-libs/dbus-glib
	dev-python/dbus-python
	>=dev-libs/glib-2.16.0
	dev-python/librsvg-python
	dev-python/pycairo
	dev-python/pygobject:2
	>=dev-python/pygtk-2.12:2
	>=gnome-base/libgtop-2
	>=x11-libs/gtk+-2.12.0
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libdesktop-agnostic[gconf?]
	x11-libs/libwnck:1
	x11-misc/dockmanager
"

RDEPEND="${COMMON_DEPEND}
	dev-python/pyxdg
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	x11-proto/compositeproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto
	!<gnome-extra/avant-window-navigator-extras-${PV}
	gconf? ( gnome-base/gconf:2 )
	doc? ( dev-util/gtk-doc )
	dev-lang/vala:0.12
"

src_unpack() {
	bzr_src_unpack
}

src_prepare() {
	gtkdocize || die "gtkdocize failed"
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf VALAC=$(type -p valac-0.12) \
		  $(use_enable doc gtk-doc) \
		  $(use_enable gconf schemas-install) \
		  $(use_with gconf gconf-schema-file-dir=/etc/gconf/schemas) \
		  --disable-static \
		  --disable-pymod-checks \
		  --disable-maintainer-mode \
		  --enable-extra-version=-gentoo-desktop-effects
}

pkg_postinst() {
	gnome2_pkg_postinst

	ewarn
	ewarn "AWN will be of no use if you do not have a compositing manager."

	python_mod_optimize awn
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup awn
}
