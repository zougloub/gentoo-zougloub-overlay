EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1 git-r3

DESCRIPTION="Character encoding auto-detection in Python."

HOMEPAGE="https://github.com/chardet/chardet"
SRC_URI=""
EGIT_REPO_URI="https://github.com/chardet/chardet.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

HTML_DOCS=( docs/ )

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.rst )
	local HTML_DOCS=( docs )
	distutils-r1_python_install_all
}

