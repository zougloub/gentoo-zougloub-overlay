EAPI=5

PYTHON_COMPAT=( python{2_{6,7},3_{1,2,3,4,5,6}} pypy{1_8,1_9} )

inherit distutils-r1 git-2

DESCRIPTION="Kalman filtering and optimal estimation library in Python"
HOMEPAGE="https://github.com/rlabbe/filterpy"
SRC_URI=""
EGIT_REPO_URI="git://github.com/rlabbe/filterpy"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

DEPEND="
 dev-python/numpy
 sci-libs/scipy
 dev-python/matplotlib
"

