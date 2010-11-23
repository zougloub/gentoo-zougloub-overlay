# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-text/pdftk/pdftk-1.41.ebuild v1 2008/12/22 09:29:31 cJ Exp $

inherit eutils

DESCRIPTION="Converts ANSI terminal sequences to HTML or RTF"
HOMEPAGE="http://www.andre-simon.de"
SRC_URI="http://www.andre-simon.de/zip/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+gui"
EAPI=2

RDEPEND="
 gui? ( x11-libs/qt-gui )
"
DEPEND="
$RDEPEND
"
RESTRICT="primaryuri"

#S=${WORKDIR}/${P}/${PN}

src_compile() {
	emake || die "emake failed"
	if use gui;
	then
		pushd src/qt-gui
		qmake || die "qmake failed"
		emake || die "emake gui failed"
		popd
	fi
}

src_install() {
	dobin src/ansifilter
	use gui && dobin src/qt-gui/ansifilter-gui
	dodoc README ChangeLog
	return
}

