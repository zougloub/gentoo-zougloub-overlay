
DESCRIPTION="Computes changes between binary or text files and creates deltas"
HOMEPAGE="http://xdelta.sourceforge.net"
SRC_URI="http://xdelta.googlecode.com/files/${P//-/}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=""

src_compile() {
	cd "${WORKDIR}/${P//-/}"
	emake || die "emake failed."
}

src_install() {
	cd "${WORKDIR}/${P//-/}"
	dobin xdelta3
	dodoc AUTHORS ChangeLog NEWS README
}
