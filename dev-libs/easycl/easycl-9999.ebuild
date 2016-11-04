EAPI=5

EGIT_REPO_URI="git://github.com/hughperkins/EasyCL"

inherit multilib cmake-utils git-r3

DESCRIPTION="OpenCL wrapper"
HOMEPAGE="https://github.com/hughperkins/EasyCL"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="
 dev-libs/clew
"
DEPEND="
 ${CDEPEND}
"
RDEPEND="
 ${CDEPEND}
"

src_prepare() {
	:
}

src_configure() {
	local mycmakeargs=(
	 -DUSE_CLEW:BOOL="0"
	)
	tc-export CC CXX
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	rm -r ${D}/usr/lib*/EasyCL
	rm -r ${D}/usr/bin/easycl_activate.sh
}
