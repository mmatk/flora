# Copyright 2008-2012 Funtoo Technologies
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils



DESCRIPTION="Display temperature/voltages/fan speeds on lxpanel through lm-sensors"
HOMEPAGE="http://danamlund.dk/sensors_lxpanel_plugin/"
SRC_URI="https://github.com/danamlund/${PN}/archive/master.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk"

DEPEND="
	lxde-base/lxpanel
	=dev-libs/glib-2*
	gtk? ( =x11-libs/gtk+-2* )
	>=sys-apps/lm_sensors-3.3.3-r2 
	lxde-base/menu-cache
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/sensors-lxpanel-plugin-master"

src_prepare() {
	epatch "${FILESDIR}"/destdir.patch
}

src_install() {
	emake DESTDIR="${D}" install || die
}

pkg_postinst() {
		elog 'Simply use the lxpanel "Add/Remove Panel Items"'
		elog "option to add lm-sensors Monitor to your panel"
}
