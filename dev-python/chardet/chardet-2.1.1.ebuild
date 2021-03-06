# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/chardet/chardet-2.0.1-r1.ebuild,v 1.6 2013/09/05 18:47:09 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1

RESTRICT=primaryuri
DESCRIPTION="Character encoding auto-detection in Python."

HOMEPAGE="http://pypi.python.org/pypi/chardet"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

HTML_DOCS=( docs/ )

src_prepare() {
	sed -i -e '40,$d' chardet/constants.py || die
	sed -i -e 's/constants.True/True/g' -e 's/constants.False/False/g' chardet/*.py || die
	sed -i -r -e 's/except (.*), /except \1 as /g' chardet/*.py || die
	#sed -i -e 's/import constants, sys/import sys\nfrom . import constants/' chardet/*.py || die
}

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.rst )
	local HTML_DOCS=( docs )
	distutils-r1_python_install_all
}

