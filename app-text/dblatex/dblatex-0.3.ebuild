# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit python distutils

DESCRIPTION="Transforms DocBook documents to LaTeX"
HOMEPAGE="http://dblatex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
EAPI="2"
IUSE=""

RESTRICT="primaryuri"

RDEPEND="
"

DEPEND="
 $RDEPEND
"

PYTHON_MODNAME="dblatex"
SUPPORT_PYTHON_ABIS="2"
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	dobin scripts/dblatex
	distutils_src_install
}

