# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/xlwt/xlwt-0.7.5.ebuild,v 1.4 2013/05/20 12:44:40 ago Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

MY_PN=PySensors
DESCRIPTION="Python bindings to libsensors (via ctypes)"
HOMEPAGE="http://pypi.python.org/pypi/pysensors"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"
S="$WORKDIR/$MY_PN-$PV"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="examples"

python_prepare_all() {
	## Don't install documentation and examples in site-packages directories.
	#sed -e "/package_data/,+6d" -i setup.py || die

	distutils-r1_python_prepare_all
}

python_install_all() {
	#local HTML_DOCS=( HISTORY.html xlwt/doc/xlwt.html )
	#use examples && local EXAMPLES=( xlwt/examples )
	distutils-r1_python_install_all

	#dodoc -r tests
	#docompress -x /usr/share/doc/${PF}/tests
}
