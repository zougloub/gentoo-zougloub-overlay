EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4,3_5,3_6} )

inherit distutils-r1 git-r3

DESCRIPTION="Ceres solver bindings for python"
HOMEPAGE="https://github.com/rougier/freetype-py"
SRC_URI=""
EGIT_REPO_URI="git://github.com/rougier/freetype-py"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

DEPEND="media-libs/freetype"

DOCS=( README.rst )

