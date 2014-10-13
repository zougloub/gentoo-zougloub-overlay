# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit git-r3 distutils-r1

DESCRIPTION="Python extension that wraps Google's RE2 library."
HOMEPAGE="https://github.com/axiak/pyre2 http://pypi.python.org/pypi/re2/"
SRC_URI="mirror://pypi/r/re2/re2-${PV}.tar.gz -> ${P}.tar.gz"

if [ "$PV" == "9999" ]; then
   EGIT_REPO_URI="git://github.com/facebook/pyre2.git"
fi

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
 dev-libs/re2
 dev-python/cython
"
RDEPEND="
 dev-libs/re2
"

if [ "$PV" == "9999" ]; then
	:
else
	S="${WORKDIR}/re2-${PV}"
fi

python_prepare_all() {
	rm -f README
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

