EAPI="2"

DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://ccxvii.net/mupdf/"

SRC_URI="http://ccxvii.net/${PN}/download/${PN}-r${PV}.tar.gz"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cjk jbig jpeg2k"
RESTRICT="primaryuri"

RDEPEND="
 sys-libs/zlib
 media-libs/jpeg
 >=media-libs/freetype-2
 jbig? ( media-libs/jbigkit )
 jpeg2k? ( media-libs/jasper )
"

DEPEND="
 ${RDEPEND}
 dev-util/ftjam
"

src_configure() {
	echo "LINKFLAGS = ${LDFLAGS} ;" >> Jamrules
	echo "OPTIM = ${CFLAGS} ;" >> Jamrules
	echo 'ALL_LOCATE_TARGET = [ FDirName $(TOP) build ] ;' >> Jamrules
	#echo 'BUILD_PLUGIN = true ;' >> Jamrules
}

src_compile() {
	local PARAMETER=""
	use cjk || PARAMETER="${PARAMETER} '-sDEFINES=NOCJK'"
	use jbig && PARAMETER="${PARAMETER} '-sHAVE_JBIG2DEC=yes'"
	use jpeg2k && PARAMETER="${PARAMETER} '-sHAVE_JASPER=yes'"
	jam ${PARAMETER} || die "jam failed"
}

src_install() {
	dodoc COPYING README || die "Could not create documents"
	cd build
	dobin cmapdump fontdump mupdf pdfclean pdfdraw pdfextract pdfshow || die "Could not create binaries"
	newbin pdfinfo mupdf_pdfinfo || die "Could not rename pdfinfo -> mupdf_pdfinfo" # avoid collision with app-text/poppler-utils
	dolib.a *.a || die "Could not create libraries"
}

