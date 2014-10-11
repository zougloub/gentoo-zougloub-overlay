EAPI=5
DESCRIPTION="Language for image processing and computational photography"
HOMEPAGE="http://halide-lang.org"
EGIT_REPO_URI="git://github.com/halide/Halide.git"
LICENSE="MIT"
KEYWORDS="~x86"
SLOT=0
IUSE=""

inherit eutils git-r3 cmake-utils

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

src_prepare() {
	sed -i -e 's/tinfo//g' src/CMakeLists.txt
}

pkg_setup() {
	:
}

src_configure() {
	local mycmakeargs=(
	 -D LLVM_INCLUDE:PATH=/usr/include
	 -D LLVM_BIN:PATH=/usr/bin
	 -D LLVM_LIB:PATH=/usr/lib
	 -D LLVM_VERSION:STRING=35
	 -D WITH_TEST_CORRECTNESS:BOOL=OFF
	 -D WITH_TEST_ERROR:BOOL=OFF
	 -D WITH_TEST_PERFORMANCE:BOOL=OFF
	 -D WITH_TEST_STATIC:BOOL=OFF
	 -D WITH_TEST_WARNING:BOOL=OFF
	 -D WITH_TEST_OPENGL:BOOL=OFF
	)

	cmake-utils_src_configure
	mkdir -p "${BUILD_DIR}/Halide.build"
}

src_test() {
	:
}

src_install() {
	cd "${BUILD_DIR}"
	dolib lib/*
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
Libs: -L/usr/lib -l Halide -l InitialModules -l pthread
Cflags: -I/usr/include
Requires: ncurses
' > Halide.pc
	doins Halide.pc
}
