EAPI=5

inherit eutils git-r3 cmake-utils

EGIT_REPO_URI="git://github.com/aewallin/opencamlib"
DESCRIPTION="c++ library for creating toolpaths for cnc-machines such as mills and lathes"
HOMEPAGE="https://github.com/aewallin/opencamlib"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="+python"
RESTRICT="primaryuri"
SLOT="0"

# TODO python

RDEPEND="

"

DEPEND="${RDEPEND}
"
