EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit distutils-r1 git-r3

DESCRIPTION="library designed to make machine learning research easy"

HOMEPAGE="http://deeplearning.net/software/pylearn2/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/lisa-lab/pylearn2.git"
LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

RDEPEND="
 >=dev-python/pyyaml-3.10
 >=dev-python/theano-0.6.0
"

DEPEND="
 >=dev-python/cython-0.19
"

src_prepare() {
	cd "$S"
	sed -i -e 's/.develop. not in sys.argv/False/g' setup.py
	sed -i -e 's/open..README.rst.*,/open("README.rst", "rb").read().decode("utf-8"),/g' setup.py
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.rst )
	distutils-r1_python_install_all
}

