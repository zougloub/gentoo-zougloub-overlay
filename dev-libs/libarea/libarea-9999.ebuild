EAPI=5

inherit eutils git-r3 cmake-utils

EGIT_REPO_URI="git://github.com/Heeks/libarea"
DESCRIPTION="Library and python module for pocketing and profiling operations"
HOMEPAGE="https://github.com/Heeks/libarea"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="+python"
RESTRICT="primaryuri"
SLOT="0"

RDEPEND="
"

DEPEND="${RDEPEND}
"
