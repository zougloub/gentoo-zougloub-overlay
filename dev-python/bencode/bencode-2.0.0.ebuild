# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_{5,6,7},3_{2,3,4,5,6}} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Simple bencode parser (for Python 2, Python 3 and PyPy)"
HOMEPAGE="https://github.com/fuzeman/bencode.py http://pypi.python.org/pypi/bencode.py"
PN_="bencode.py"
SRC_URI="mirror://pypi/${PN_:0:1}/${PN_}/${PN_}-${PV}.tar.gz"
S="${WORKDIR}/${PN_}-${PV}"

RESTRICT="primaryuri"
LICENSE="Bittorrent"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	local DOCS=( README.rst )
	distutils-r1_python_install_all
}

