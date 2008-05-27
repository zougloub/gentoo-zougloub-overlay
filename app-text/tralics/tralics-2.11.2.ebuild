

DESCRIPTION="Tralics: a LaTeX to XML translator"
HOMEPAGE="http://www-sop.inria.fr/apics/tralics/"
SRC_URI=" ftp://ftp-sop.inria.fr/apics/tralics-src/${P//tralics/tralics-src}.tar.gz"
RESTRICT="primaryuri"

LICENSE="CeCILL"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="
	virtual/tex-base
	"
SLOT="0"

src_compile() {
	cd src
	emake
}


src_install() {
	dobin src/tralics
	dodoc README COPYING
	mkdir ${D}/usr/share/${PN}
	cp -R confdir styles xml ${D}/usr/share/${PN}/
}

src_test() {
	cd ${S}/test
	${D}/usr/bin/tralics *
}