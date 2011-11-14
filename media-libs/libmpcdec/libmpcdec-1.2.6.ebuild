# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit autotools

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://files2.musepack.net/source/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 mips ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc static"

src_configure() {
	econf \
		$(use_enable static) \
		$(use_enable !static shared)
}

src_compile() {
	emake
}

src_install() {
	einstall #make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README
	use doc && dohtml docs/html/*
}

