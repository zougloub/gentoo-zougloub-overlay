inherit eutils

MY_P="${P/_/-}"
DESCRIPTION="A parallel version of bzip2"
HOMEPAGE="http://bzip2smp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

RDEPEND=""
DEPEND=""

S=${WORKDIR}/${MY_P}

src_install() {
	dobin bzip2smp || die "Can't dobin"
	dodoc README || die "Can't dodoc"
}
