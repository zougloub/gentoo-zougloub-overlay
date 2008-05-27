KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
DESCRIPTION="bsed is the binary stream editor. Can be *very* fast."
HOMEPAGE="http://www1.bell-labs.com/cgi-user/wwexptools/gensnapshot?bsed"
#SRC_URI="http://www1.bell-labs.com/cgi-user/wwexptools/gensnapshot/source/bsedsrc.tar.gz"
SRC_URI="http://Gentoo.zapto.org/unversionned-packages/${P}.tar.gz"
LICENSE="LPL"
SLOT="0"
DEPEND=""
RESTRICT="primaryuri"

src_compile() {
	cd ${WORKDIR}/bsedsrc
	make bsed || die
}

src_install() {
	cd ${WORKDIR}/bsedsrc
	dobin bsed || die "Can't dobin"
	dodoc homepage/*
}
