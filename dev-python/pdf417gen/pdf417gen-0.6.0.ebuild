# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2,3_3,3_4,3_5,3_6} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="PDF417 barcode generator for Python"
HOMEPAGE="https://github.com/ihabunek/pdf417-py"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

RESTRICT="primaryuri"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

