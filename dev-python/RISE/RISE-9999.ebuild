EAPI=5

PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3,4,5,6}} pypy{1_8,1_9} )

inherit distutils-r1 git-r3

DESCRIPTION="Reveal.js - Jupyter/IPython Slideshow Extension"
HOMEPAGE="https://github.com/damianavila/RISE"
SRC_URI=""
EGIT_REPO_URI="git://github.com/damianavila/RISE"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

DOCS=( README.md )

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

pkg_postinst() {
	jupyter-nbextension install rise --py --sys-prefix
	jupyter-nbextension enable rise --py --sys-prefix
}
