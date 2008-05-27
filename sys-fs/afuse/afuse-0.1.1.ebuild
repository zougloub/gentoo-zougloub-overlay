KEYWORDS="x86"
DESCRIPTION="Automounter for FUSE"
HOMEPAGE="http://afuse.sourceforge.net/ http://sourceforge.net/projects/afuse/"
SRC_URI="mirror://sourceforge/afuse/${PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
RESTRICT="primaryuri"

RDEPEND=">=sys-fs/fuse-2.0"

src_install() {
	dobin src/afuse
	dodoc INSTALL README NEWS
}

