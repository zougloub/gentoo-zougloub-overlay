inherit eutils

DESCRIPTION="mms protocol download utility"
HOMEPAGE="http://www.geocities.com/majormms/"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc sparc x86"
IUSE=""

S=${WORKDIR}/mms_client-${PV}

src_unpack() {
        unpack ${A}
        cd "${S}"
#        epatch "${FILESDIR}"/${PF}.patch
#        epatch "${FILESDIR}"/${P}-fbsd.patch
}

src_install() {
        make DESTDIR="${D}" install || die
}

