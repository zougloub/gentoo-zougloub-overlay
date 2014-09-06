# Copyright 2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils git-2

DESCRIPTION="The Beignet GPGPU System for Intel GPUs"
HOMEPAGE="http://wiki.freedesktop.org/www/Software/Beignet/"

EGIT_REPO_URI="git://anongit.freedesktop.org/beignet"
EGIT_COMMIT="Release_v${PV}"

LICENSE="GPL-2"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
 >=dev-util/opencl-headers-1.2
 >=sys-devel/gcc-4.6
 dev-libs/ocl-icd
"

RDEPEND="
 app-admin/eselect-opencl
 media-libs/mesa
 sys-devel/clang
 >=sys-devel/llvm-3.1
 x11-libs/libdrm
 x11-libs/libXext
 x11-libs/libXfixes
"

src_prepare() {
	# Disable tests
	sed -i "s/ADD_SUBDIRECTORY(utests)/#ADD_SUBDIRECTORY(utests)/" CMakeLists.txt || die "sed failed"

	# Work around CMAKE flags
	perl -p -i -e 's/(CMAKE_C_CXX_FLAGS) (-DGBE_COMPILER_AVAILABLE=1)/$1 "$2 \${CMAKE_C_CXX_FLAGS}"/g' backend/CMakeLists.txt

	cmake-utils_src_prepare
}

src_configure() {
	CFLAGS+=" -DGBE_DEBUG=0 -DNDEBUG"
	CXXFLAGS+=" -DGBE_DEBUG=0 -DNDEBUG"
	local mycmakeargs=(
	 -D CMAKE_C_FLAGS:STRING="$CFLAGS"
	 -D CMAKE_C_FLAGS_RELEASE:STRING="$CFLAGS"
	 -D CMAKE_C_CXX_FLAGS:STRING="$CXXFLAGS"
	 -D CMAKE_C_CXX_FLAGS_RELEASE:STRING="$CXXFLAGS"
	 -D CMAKE_CXX_FLAGS:STRING="$CXXFLAGS"
	 -D CMAKE_CXX_FLAGS_RELEASE:STRING="$CXXFLAGS"
	 -D CMAKE_INSTALL_PREFIX:STRING="/usr/lib/OpenCL/vendors/intel-beignet"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc README.md
	einfo "Moving files into vendor-specific position..."
}

