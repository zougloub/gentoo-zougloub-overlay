# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit python distutils

DESCRIPTION="Transforms DocBook documents to LaTeX"
HOMEPAGE="http://dblatex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RESTRICT="primaryuri"

RDEPEND="
"

PYTHON_MODNAME="dbtexmf"
SUPPORT_PYTHON_ABIS="2"
RESTRICT_PYTHON_ABIS="3.*"

src_prepare() {
	sed -i.bak \
	 -r -e 's|^(package_base = ).*$|\1"/usr/share/dblatex"|g' \
	 scripts/dblatex
}

src_install() {
	dobin scripts/dblatex
	distutils_src_install
}

