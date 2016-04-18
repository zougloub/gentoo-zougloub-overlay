EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3,3_4} pypy{1_8,1_9} )

inherit distutils-r1 git-r3

DESCRIPTION="A Python module to deal with freedesktop.org specifications"
HOMEPAGE="https://github.com/SolidCode/SolidPython"
SRC_URI=""
EGIT_REPO_URI="https://github.com/SolidCode/SolidPython.git"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="test"

DEPEND=""

DOCS=( README.rst )

