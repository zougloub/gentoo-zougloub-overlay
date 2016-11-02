EAPI=5

inherit git-r3 cmake-utils

EGIT_REPO_URI="https://github.com/viennacl/viennacl-dev.git"

DESCRIPTION="ViennaCL - A Linear algebra library for computations on GPUs and multi-core CPUs"
HOMEPAGE="http://viennacl.sourceforge.net"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

DEPEND="
 virtual/opencl
 dev-libs/pugixml
"
RDEPEND="${DEPEND}"

