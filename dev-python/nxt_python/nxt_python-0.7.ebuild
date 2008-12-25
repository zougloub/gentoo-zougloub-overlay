# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit distutils

DESCRIPTION="NXT_Python is a package for controlling a LEGO NXT robot using the Python programming language"
HOMEPAGE="http://home.comcast.net/~dplau/nxt_python/index.html"
SRC_URI="http://home.comcast.net/~dplau/nxt_python/download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
EAPI="2"
IUSE="-bluetooth +usb"

RDEPEND="
 usb? ( dev-python/pyusb )
 bluetooth? ( dev-python/pybluez )
"

DEPEND="
 $RDEPEND
"

src_install() {
	distutils_src_install
	ebegin Adding examples
	insinto /usr/share/${PN}/examples
	doins examples/*
	eend $?
}