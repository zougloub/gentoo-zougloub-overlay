EAPI=5
CMAKE_BUILD_TYPE=Release
inherit cmake-utils git-r3

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

src_configure() {
	local mycmakeargs=(
		-DINSTALL_UDEV_RULES=ON
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="README" cmake-utils_src_install
}
