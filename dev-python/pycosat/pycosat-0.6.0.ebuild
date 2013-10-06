# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Python bindings to libsensors (via ctypes)"
HOMEPAGE="http://pypi.python.org/pypi/pycosat"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="+examples"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	local DOCS=( README.rst )
	use examples && local EXAMPLES=( examples )
	distutils-r1_python_install_all
}

