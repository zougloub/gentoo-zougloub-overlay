# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils

DESCRIPTION="Convert between any document format supported by OpenOffice"
HOMEPAGE="http://dag.wieers.com/home-made/unoconv/"
SRC_URI="http://dag.wieers.com/home-made/unoconv/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror primaryuri"

RDEPEND="
 >=dev-lang/python-2.5
 || ( app-office/openoffice app-office/openoffice-bin )
"
DEPEND="
 dev-python/setuptools
"

src_prepare() {
	epatch "${FILESDIR}/${P}-openoffice-3.2.patch"
	epatch "${FILESDIR}/${P}-longer-timeout.patch"
}

src_install() {
	emake install DESTDIR="${D}"
}
