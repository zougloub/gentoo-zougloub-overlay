# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3,3_4,3_5} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="a list-like type with better asymptotic performance and similar performance on small lists"
HOMEPAGE="http://pypi.python.org/pypi/blist"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~ppc-aix ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}
"

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( *.rst )
	distutils-r1_python_install_all
}
