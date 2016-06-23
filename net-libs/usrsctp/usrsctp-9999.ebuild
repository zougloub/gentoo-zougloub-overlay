EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="SCTP user-land implementation"
HOMEPAGE="https://github.com/sctplab/usrsctp"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sctplab/usrsctp"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

src_configure() {

	# Work around build failure with recent GCC (uninitialized fields)
	local mycmakeargs=(
	 -DWERROR=OFF
	)
	cmake-utils_src_configure
}

