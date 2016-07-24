EAPI=5
DESCRIPTION="ndarray for gpu"
HOMEPAGE="http://deeplearning.net/software/libgpuarray/"
EGIT_REPO_URI="git://github.com/Theano/libgpuarray.git"
LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT=0
IUSE=""

PYTHON_COMPAT=( python{2_6,2_7,3_4} )

inherit eutils git-r3 cmake-utils distutils-r1

# TODO CUDA OPENCL CLBLAS

RDEPEND="
 sci-libs/clblas
"

DEPEND="
 $RDEPEND
"

src_prepare() {
	cmake-utils_src_prepare
	distutils-r1_src_prepare
}

src_configure() {
	cmake-utils_src_configure
	distutils-r1_src_configure
}

src_compile() {
	cmake-utils_src_compile
	distutils-r1_src_compile
}

src_install() {
	cmake-utils_src_install
	distutils-r1_src_install
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
