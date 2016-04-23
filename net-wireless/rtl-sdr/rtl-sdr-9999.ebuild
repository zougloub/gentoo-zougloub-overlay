EAPI=5

inherit cmake-utils git-r3 toolchain-funcs multilib-minimal

DESCRIPTION="RTL2832U interface"
HOMEPAGE="http://sdr.osmocom.org/trac/wiki/rtl-sdr"
SRC_URI=""
EGIT_REPO_URI="git://git.osmocom.org/rtl-sdr.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 >=dev-libs/libusb-1.0
"
DEPEND="${RDEPEND}
"

multilib_src_configure() {
	local mycmakeargs=(
		-DINSTALL_UDEV_RULES=ON
	)
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	DOCS="README" cmake-utils_src_install
	mv ${D}/usr/{lib,$(get_abi_LIBDIR)}
}
