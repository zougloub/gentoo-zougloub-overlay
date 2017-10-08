# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit git-r3 distutils-r1

DESCRIPTION="Lightweight, extensible schema and data validation tool for Python dictionaries."
HOMEPAGE="http://python-cerberus.org"
SRC_URI="mirror://pypi/c/cerberus/cerberus-${PV}.tar.gz -> ${P}.tar.gz"

if [ "$PV" == "9999" ]; then
   EGIT_REPO_URI="git://github.com/nicolaiarocci/cerberus"
   SRC_URI=""
fi

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
"
RDEPEND="
"

if [ "$PV" == "9999" ]; then
	:
else
	S="${WORKDIR}/cerberus-${PV}"
fi

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

