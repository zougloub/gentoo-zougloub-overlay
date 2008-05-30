
DESCRIPTION="Daemon for transparent IP (Layer 3) proxy ARP bridging"
HOMEPAGE="http://freshmeat.net/projects/parprouted/ http://www.hazard.maks.net"
SRC_URI="http://www.hazard.maks.net/parprouted/${PN}-${PV}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
RDEPEND="sys-apps/usermode-utilities"

src_compile() {
	emake || die "Emake failed"
}

src_install () {
	dosbin parprouted
	doman parprouted.8
}
