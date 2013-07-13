EAPI=5

inherit git-2

DESCRIPTION="Tool that graphs the results of a blktrace run"
HOMEPAGE="http://masoncoding.com/iowatcher/"
SRC_URI=""
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/mason/iowatcher.git"

RDEPEND=""
DEPEND="$RDEPEND
"

src_install() {
	einstall
	dodoc README
	doman iowatcher.1
}

