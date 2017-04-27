EAPI="5"

PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3,3_4,3_5} pypy{1_9,2_0} )

inherit distutils-r1 git-r3

DESCRIPTION="Deep Learning library for Python. Convnets, recurrent neural networks, and more. Runs on TensorFlow or Theano"
HOMEPAGE="https://github.com/fchollet/keras"
SRC_URI=""
EGIT_REPO_URI="git://github.com/fchollet/keras"
LICENSE="MIT"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~x86"

RDEPEND="
"
DEPEND="
 >=dev-python/setuptools-24.0.1
 $RDEPEND
"

src_prepare() {
	distutils-r1_src_prepare
}

src_compile() {
	distutils-r1_src_compile
	#$(use threads || echo --without-threading)
}

src_test() {
	testing() {
		:
	}
	python_execute_function testing
}

src_install() {
	distutils-r1_src_install
}

pkg_setup() {
	python-any-r1_pkg_setup
}

