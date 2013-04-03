# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
inherit eutils

DESCRIPTION="A reference open-source implementation of DLNA (Digital Living Network Alliance) standards."
HOMEPAGE="http://libdlna.geexbox.org"
SRC_URI="http://libdlna.geexbox.org/releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-video/ffmpeg-0.5"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-libavcodec-libavformat-include-paths.patch"
}

src_configure() {
	# I can't use econf
	# --host is not implemented in ./configure file
	./configure \
		--prefix=/usr \
		|| die "./configure failed"
}

src_compile() {
	# not parallel safe, error "cannot find -ldlna"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc README AUTHORS ChangeLog || die
}
