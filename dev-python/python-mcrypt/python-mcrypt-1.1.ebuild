# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Python interface to mcrypt library"
HOMEPAGE="http://labix.org/python-mcrypt http://pypi.python.org/pypi/python-mcrypt"
#SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
SRC_URI="http://labix.org/download/${PN}/${P}.tar.gz"
LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
 >=dev-libs/libmcrypt-2.5.0:0
"

RDEPEND="
 >=dev-libs/libmcrypt-2.5.0:0
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

