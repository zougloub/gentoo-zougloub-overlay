# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="The rtptools distribution consists of a number of small applications that can be used for processing RTP data."
HOMEPAGE="http://www.cs.columbia.edu/irt/software/rtptools"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
RESTRICT="nomirror"
SLOT="0"
SRC_URI="http://www.cs.columbia.edu/irt/software/rtptools/download/${P}.tar.gz"

IUSE=""

RDEPEND="
 virtual/libc
"

DEPEND="
 ${RDEPEND}
"

src_configure() {
	econf \
	 || die "Configure failed"
}

src_install() {
	emake install DESTDIR=${D} || die "Could not make install"
	dodoc README
}

