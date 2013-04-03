# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4-python

EBZR_REPO_URI="lp:awn-extras"
PYTHON_MULTIPLE_ABIS="1"
PYTHON_RESTRICTED_ABIS="3.* *-jython"

inherit autotools bzr distutils gnome2 python

DESCRIPTION="Fully customizable dock for the Free desktop"
HOMEPAGE="https://launchpad.net/awn"
SRC_URI=""
LICENSE="GPL-2 LGPL-2.1 CCPL-Attribution-ShareAlike-3.0"

SLOT="0"
KEYWORDS=""
IUSE="gconf gnome tomboy webkit"

COMMON_DEPEND="
	dev-libs/dbus-glib
	>=dev-libs/glib-2.16.0
	dev-python/librsvg-python
	dev-python/pygobject:2
	>=dev-python/pygtk-2.12:2
	dev-python/dbus-python
	dev-python/pycairo
	>=gnome-base/libgtop-2
	>=x11-libs/gtk+-2.12.0
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libdesktop-agnostic[gconf?]
	>=x11-libs/libwnck-2.22
	x11-libs/startup-notification
	x11-misc/dockmanager
	x11-libs/vte:0
"
RDEPEND="${COMMON_DEPEND}
	$(python_abi_depend dev-python/pyxdg)
"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	x11-proto/compositeproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xproto
	games-misc/fortune-mod
	dev-python/python-dateutil
	dev-python/vobject
	dev-python/gst-python
	dev-python/libgtop-python
	dev-python/notify-python
	$(python_abi_depend dev-python/gdata)
	$(python_abi_depend dev-python/feedparser)
	dev-python/libwnck-python
	dev-python/python-xklavier
	dev-libs/libgweather
	!<gnome-extra/avant-window-navigator-extras-${PV}
	gconf? ( gnome-base/gconf:2 )
	tomboy? ( app-misc/tomboy )
	webkit? ( net-libs/webkit-gtk )
	dev-lang/vala:0.12
"
DOCS="AUTHORS ChangeLog NEWS README"
export CFLAGS="${CFLAGS} -I/usr/include/gio-unix-2.0/"

src_unpack() {
	bzr_src_unpack
}

src_prepare() {
	intltoolize --copy --force || die "intltoolize failed"
	eautoreconf || die "eautoreconf failed"
}

src_configure() {
	econf VALAC=$(type -p valac-0.12) \
		$(use_enable gconf schemas-install) \
		$(use_with gnome) \
		$(use_with webkit) \
		--disable-static \
		--disable-pymod-checks
}
