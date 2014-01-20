# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Pure-python wrapper for libusb-1.0"
HOMEPAGE="http://pypi.python.org/pypi/libusb1"
SRC_URI="https://pypi.python.org/packages/source/l/libusb1/${P}.tar.gz"

LICENSE="GPL"
KEYWORDS="~x86"
SLOT="0"

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.rst )
	distutils-r1_python_install_all
}

