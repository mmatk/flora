# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
PYTHON_DEPEND="2"
RESTRICT_PYTHON_ABIS="3.*"
inherit gnome2 python

DESCRIPTION="Dock-independent helper scripts"
HOMEPAGE="https://launchpad.net/dockmanager"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gconf"

RDEPEND="dev-libs/dbus-glib
	dev-libs/glib:2
	x11-libs/gtk+:2
	x11-libs/libdesktop-agnostic"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-lang/vala:0.10"

pkg_setup() {
	export VALAC="$(type -P valac-0.10)"
	export VALA_GEN_INTROSPECT="$(type -P vapigen-0.10)"

	DOCS="AUTHORS"
	python_set_active_version 2
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-fix-no-return.patch"

	rm -f {scripts,metadata}/pidgin_control.* || die
	sed -i -e "/pidgin_control/d" {scripts,metadata}/Makefile.* || die
}

src_configure() {
	gnome2_src_configure \
		$(use_enable debug) \
		$(use_enable !debug release) \
		$(use_enable gconf schemas-install) \
		--disable-static
}

pkg_postinst() {
	gnome2_pkg_postinst

	python_mod_optimize dockmanager
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup dockmanager
}
