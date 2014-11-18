EAPI=5
DESCRIPTION="Language for image processing and computational photography"
HOMEPAGE="http://halide-lang.org"
EGIT_REPO_URI="git://github.com/halide/Halide.git"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT=0
IUSE=""

inherit eutils git-r3

RDEPEND="
 virtual/opencl
 >=sys-devel/llvm-3.5[clang]
"

DEPEND="
 $RDEPEND
"

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	cd "${BUILD_DIR}"
	dolib bin/libHalide.a
	insinto /usr/include
	doins include/*
	insinto /usr/lib/pkgconfig
	echo '
prefix=/usr
exec_prefix=
libdir=/usr/lib64
includedir=/include

Name: Halide
Description: Language for image processing and computational photography
Version: 0.1
Libs: -L/usr/lib -lHalide ' $(llvm-config --system-libs) '
Cflags: -I/usr/include
Requires: ncurses
' > Halide.pc
	doins Halide.pc
}
