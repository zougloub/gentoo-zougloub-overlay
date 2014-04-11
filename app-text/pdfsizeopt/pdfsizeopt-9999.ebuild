# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git-r3

DESCRIPTION="PDF file size optimizer"
HOMEPAGE="http://code.google.com/p/pdfsizeopt"
SRC_URI=""
EGIT_REPO_URI="https://code.google.com/p/pdfsizeopt"

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
}
