inherit eutils

DESCRIPTION="trickle is a portable lightweight userspace bandwidth shaper. It can run in collaborative mode or in stand alone mode"
HOMEPAGE="http://monkey.org/~marius/pages/?page=trickle"
SRC_URI="http://monkey.org/~marius/trickle/${P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
DEPEND="dev-libs/libevent"
RDEPEND="$DEPEND"


src_unpack() {
        unpack ${A}
        cd "${S}"
        epatch "${FILESDIR}"/cantcompile.patch
}


src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
	dodoc TODO
}
