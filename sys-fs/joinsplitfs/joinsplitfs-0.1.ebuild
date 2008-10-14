DESCRIPTION="FUSE modules to joins multiple files to one pseudo-file, or provide direct access to parts of one file by representing them as pseudo-files"
SRC_URI="mirror://sourceforge/joinsplitfs/${PN}-v${PV}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/joinsplitfs/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
DEPEND="sys-fs/fuse"

src_compile() {
	cd $WORKDIR/${PN}-v${PV}
        make CC=$CC || die "Could not make"
}

src_install() {
	cd $WORKDIR/${PN}-v${PV}
        dobin joinfs || die "Could not dobin joinfs binary"
        dobin splitfs || die "Could not dobin splitfs binary"
	dodoc README || die "Could not dodoc"
}
