#inherit eutils

KEYWORDS="~x86 ~amd64"
DESCRIPTION="High compression tool for large single files"
HOMEPAGE="http://ck.kolivas.org/apps/lrzip/"
SRC_URI="http://ck.kolivas.org/apps/lrzip/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	app-arch/bzip2
	app-arch/lzop
	dev-libs/lzo
	sys-libs/zlib
"
RDEPEND="$DEPEND"

pkg_postinst() {
	ewarn "Report installation failures to cJ@rez-metz.supelec.fr !"
}

