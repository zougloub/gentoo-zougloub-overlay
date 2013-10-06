# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="SAT solver"
HOMEPAGE="http://fmv.jku.at/picosat/"
SRC_URI="http://fmv.jku.at/picosat/picosat-${PV}.tar.gz"

RESTRICT="primaryuri"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

src_configure() {
	./configure
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin pico{sat,mcs,mus,gcnf}
	dodoc NEWS README
}

