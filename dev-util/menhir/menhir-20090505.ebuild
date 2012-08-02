# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Objective Caml parser generator"
HOMEPAGE="http://gallium.inria.fr/~fpottier/menhir/"
SRC_URI="http://gallium.inria.fr/~fpottier/menhir/${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="
 dev-lang/ocaml
"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}"

src_compile() {
	make PREFIX=/usr \
	 || die "emake failed"
}

src_install() {
	make PREFIX=/usr install \
	 bindir="${D}/usr/bin" \
	 libdir="${D}/usr/share/menhir" \
	 mandir="${D}/usr/share/man/man1" \
	 docdir="${D}/usr/share/doc/menhir" \
	 || die "einstall failed"
}
