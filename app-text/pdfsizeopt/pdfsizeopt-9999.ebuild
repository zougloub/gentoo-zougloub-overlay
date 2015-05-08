# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-r3

DESCRIPTION="PDF file size optimizer"
HOMEPAGE="https://github.com/pts/pdfsizeopt"
SRC_URI=""
EGIT_REPO_URI="https://github.com/pts/pdfsizeopt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 >=app-text/ghostscript-gpl-8.59
 >=media-libs/jbig2enc-0.28
 >=media-gfx/sam2p-0.47
"
DEPEND="
 ${RDEPEND}
"

src_prepare() {
	cd "${S}"
}

src_compile() {
	:
}

src_test() {
	:
}

src_install() {
	dobin pdfsizeopt.single
	ewarn "As of now, you need to invoke the program with"
	ewarn " pdfsizeopt.single --use-pngout=false --use-multivalent=no <file>"
	ewarn "Because pdfsizeopt is not distribution-friendly..."
	ewarn "... and we miss Multivalent.jar and pngout"
}

