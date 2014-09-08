EAPI=5
DESCRIPTION="OpenCL FFT library"
HOMEPAGE="http://clmathlibraries.github.io/clFFT/"
EGIT_REPO_URI="https://github.com/clMathLibraries/clFFT.git"
LICENSE="Apache"
KEYWORDS="~x86"
SLOT=0
IUSE=""

inherit eutils git-r3 cmake-utils

RDEPEND="
 virtual/opencl
"

DEPEND="
 doc? ( app-doc/doxygen virtual/latex-base )
 $RDEPEND
"

S="$WORKDIR/$P/src"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	grep "Requires" library/clFFT.pc.in && die "Need to fix the ebuild"
	echo "Requires: OpenCL" >> library/clFFT.pc.in
}

src_configure() {
	local mycmakeargs=(
		-D BUILD_CLIENT:BOOL=OFF
		-D BUILD_TEST:BOOL=OFF
		-D BUILD_LOADLIBRARIES:BOOL=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc ../README.md
}

