# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit multilib

MY_P="${PN}${PV}"

DESCRIPTION="Library that allows a direct access to a USB device"
HOMEPAGE="http://www.ftdichip.com/Drivers/D2XX.htm"
SRC_URI="http://www.ftdichip.com/Drivers/D2XX/Linux/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"
RESTRICT="primaryuri"

S=${WORKDIR}/${PN}${PV}

src_install() {
	insinto /usr/include
	doins ftd2xx.h WinTypes.h

	use x86 && cd build/i386
	use amd64 && cd build/x86_64

	into /opt
	dolib.so ${PN}.so.${PV}
	dosym ${PN}.so.${PV} /opt/$(get_libdir)/${PN}.so.${PV:0:1}
	dosym ${PN}.so.${PV:0:1} /opt/$(get_libdir)/${PN}.so
	dolib.a ${PN}.a
}

