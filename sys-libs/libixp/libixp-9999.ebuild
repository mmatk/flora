# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit toolchain-funcs mercurial

: ${EHG_REPO_URI:="http://hg.suckless.org/${PN}"}

DESCRIPTION="A stand-alone client/server 9P library including ixpc client"
HOMEPAGE="http://libs.suckless.org/libixp"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="app-arch/xz-utils"

S="${WORKDIR}/${PN}"

pkg_setup() {
	myixpconf=(
		PREFIX="/usr"
		LIBDIR="/usr/$(get_libdir)"
		CC="$(tc-getCC) -c"
		LD="$(tc-getCC) ${LDFLAGS}"
		AR="$(tc-getAR) crs"
		MAKESO="1"
		SOLDFLAGS="-shared -Wl,-soname"
		)
}

src_compile() {
	emake "${myixpconf[@]}" || die "emake failed"
}

src_install() {
	emake "${myixpconf[@]}" DESTDIR="${D}" install || die "emake install failed"
	dolib.so lib/libixp{,_pthread}.so || die "dolib.so failed"
	dodoc NEWS
}
