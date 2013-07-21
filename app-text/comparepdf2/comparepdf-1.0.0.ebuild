# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diffpdf/diffpdf-1.2.2.ebuild,v 1.1 2011/09/06 22:56:36 reavertm Exp $

EAPI="2"

inherit qt4-r2

DESCRIPTION="Command-line program that textually or visually compares two PDF files"
HOMEPAGE="http://www.qtrac.eu/comparepdf.html"
SRC_URI="http://www.qtrac.eu/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="
	>=app-text/poppler-0.12.3[qt4]
	>=dev-qt/qtcore-4.5:4
	>=dev-qt/qtgui-4.5:4
"
RDEPEND="${DEPEND}"

DOCS="README"

src_install() {
	qt4-r2_src_install

	dobin comparepdf || die 'dobin failed'
	doman comparepdf.1 || die 'doman failed'
}
