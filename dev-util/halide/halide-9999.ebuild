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
 >=sys-devel/llvm-3.2[clang]
"

DEPEND="
 $RDEPEND
"

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	:
}

pkg_setup() {
	:
}

src_configure() {
	local mycmakeargs=(
	 -D LLVM_INCLUDE:PATH=/usr/include
	 -D LLVM_BIN:PATH=/usr/bin
	 -D LLVM_LIB:PATH=/usr/lib
	 -D LLVM_VERSION:STRING=34
	 -D WITH_TEST_CORRECTNESS:BOOL=OFF
	 -D WITH_TEST_ERROR:BOOL=OFF
	 -D WITH_TEST_PERFORMANCE:BOOL=OFF
	 -D WITH_TEST_STATIC:BOOL=OFF
	 -D WITH_TEST_WARNING:BOOL=OFF
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
}
