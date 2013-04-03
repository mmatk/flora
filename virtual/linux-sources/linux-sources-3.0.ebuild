# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Virtual for Linux kernel sources"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="|| (
		>=sys-kernel/gentoo-sources-3.0
		>=sys-kernel/debian-sources-3.0
		>=sys-kernel/vanilla-sources-3.0
		>=sys-kernel/git-sources-3.0
		>=sys-kernel/mm-sources-3.0
	)"
