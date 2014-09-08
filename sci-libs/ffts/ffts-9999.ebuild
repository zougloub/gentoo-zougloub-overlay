EAPI=5
DESCRIPTION="FFTS FFT library"
HOMEPAGE="http://github.com/anthonix/ffts"
EGIT_REPO_URI="git://github.com/anthonix/ffts.git"
LICENSE="BSD"
KEYWORDS="~x86"
SLOT=0
IUSE="+sse -neon"

inherit eutils git-r3 autotools autotools-utils

RDEPEND="
"

DEPEND="
 $RDEPEND
"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	eautoreconf
}

src_configure() {
	local myeconfargs=(
	 $(use_enable sse)
	 $(use_enable neon)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	dodoc README
}

