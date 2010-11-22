# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

MY_P=cgx_${PV}

DESCRIPTION="A Free Software Three-Dimensional Structural Finite Element Program"
HOMEPAGE="http://www.calculix.de/"
SRC_URI="http://www.dhondt.de/${MY_P}.all.tar.bz2
	doc? ( http://www.dhondt.de/${MY_P}.ps.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +examples"

DEPEND="
 doc? ( virtual/ghostscript )
 >=virtual/glut-1.0
"

S=${WORKDIR}/CalculiX

src_unpack() {
	unpack ${A}
}

src_prepare() {
	cd ${MY_P}/src

	ebegin "Patching makefile's {C,F}FLAGS and library paths to not use contrib	stuff, but what we have in system"
	sed -i.bak \
	 -e 's|^CFLAGS.*|CFLAGS = -Wall -O3 \\|g' \
	 -e 's|lGLU|lGLU -lglut|g' \
	 -e 's|L/usr/X11/lib|L/usr/X11/lib $(PTHREAD)|g' \
	 -e 's|../../glut-3.5/src/.* \\| \\|g' \
	 Makefile \
	 || die "sed failed"
	eend $?
}


src_compile () {
	if built_with_use media-libs/mesa nptl; then
		export PTHREAD="-lpthread"
	else
		export PTHREAD=""
	fi

	cd ${MY_P}/src/
	emake || die "emake failed"
}

src_install () {
	cd ${MY_P}/src/
	dobin cgx || die "dobin failed"

	if use doc; then
		insinto /usr/share/doc/${PF}
		cd "${WORKDIR}"
		ps2pdf ${MY_P}.ps ${MY_P}.pdf
		doins ${MY_P}.pdf
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${S}"/${MY_P}/examples/*
	fi
}
