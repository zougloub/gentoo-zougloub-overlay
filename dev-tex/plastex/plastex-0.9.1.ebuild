# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit distutils

DESCRIPTION="plasTeX is a LaTeX document processing framework written entirely in Python. It converts documents to XML/XHTML"
HOMEPAGE="http://plastex.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RDEPEND=""

DEPEND="
 $RDEPEND
"

#src_install() {
#	distutils_src_install
#}
