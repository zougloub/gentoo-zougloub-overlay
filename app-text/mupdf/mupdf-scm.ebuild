EAPI="3"

inherit git-2


DESCRIPTION="a lightweight PDF viewer and toolkit written in portable C"
HOMEPAGE="http://mupdf.googlecode.com/"

SRC_URI=""
EGIT_REPO_URI="git://git.ghostscript.com/mupdf.git"
S="${WORKDIR}/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 sys-libs/zlib
 virtual/jpeg
 >=media-libs/freetype-2
 media-libs/jbig2dec
 media-libs/openjpeg
"

DEPEND="
 ${RDEPEND}
"

src_compile() {
	emake
}

src_install() {
	dodoc COPYING README || die "Could not create documents"
	cd build/debug
	dobin cmapdump fontdump mupdf pdfclean pdfdraw pdfextract pdfshow || die "Could not create binaries"
	newbin pdfinfo mupdf_pdfinfo || die "Could not rename pdfinfo -> mupdf_pdfinfo" # avoid collision with app-text/poppler-utils
	dolib.a *.a || die "Could not create libraries"
}

