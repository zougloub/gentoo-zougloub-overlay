# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="simple command-line utilities for manipulating with high dynamic range images in OpenEXR format"
HOMEPAGE="http://scanline.ca/exrtools/"
SRC_URI="http://scanline.ca/exrtools/exrtools-0.4.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 >=media-libs/libpng-1.6.21
 >=media-libs/openexr-2.1.0
"
DEPEND="
 ${RDEPEND}
"

src_prepare() {
	sed -i -e 's/Z_BEST_COMPRESSION/9/g' src/pngoutput.c
}
