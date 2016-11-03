EAPI=5

EGIT_REPO_URI="git://github.com/OpenCLWrangler/clew"

inherit multilib cmake-utils git-r3

DESCRIPTION="OpenCL extensions wrangler"
HOMEPAGE="https://github.com/OpenCLWrangler/clew"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND="
"
DEPEND="
	${CDEPEND}
"
RDEPEND="
	${CDEPEND}
"

src_prepare() {
	sed -i -e 's/add_library(clew/add_library(clew SHARED/g' CMakeLists.txt
}
