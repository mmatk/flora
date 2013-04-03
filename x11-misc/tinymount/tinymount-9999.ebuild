# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

LANGS="ru"

if [[ ${PV} == *9999 ]]; then
	SCM="git-2"
	EGIT_REPO_URI="https://github.com/limansky/tinymount.git"
else
	SRC_URI="http://github.com/downloads/limansky/tinymount/${P}.tar.bz2"
fi

inherit qt4-r2 ${SCM}

DESCRIPTION="Simple disk mount utility"
HOMEPAGE="http://github.com/limansky/tinymount"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug libnotify"

DEPEND="dev-qt/qtgui:4
	dev-qt/qtdbus:4
	libnotify? ( x11-libs/libnotify )"
RDEPEND="${DEPEND}
		sys-fs/udisks"

src_configure() {
		local params="PREFIX=/usr"
		use libnotify && params="${params} CONFIG+=with_libnotify"
		eqmake4 ${params}
}

src_install() {
		qt4-r2_src_install

		# remove unneed translations
		for lang in ${LANGS} ; do
			if ! has ${lang} ${LINGUAS} ; then
				rm ${D}/usr/share/${PN}/${PN}_${lang}.qm \
					|| eqawarn "Failed to remove ${lang} translation"
			fi
		done

		# installing docs
		dodoc README.md ChangeLog
}
