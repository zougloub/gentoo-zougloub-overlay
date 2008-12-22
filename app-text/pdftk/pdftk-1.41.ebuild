# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: app-text/pdftk/pdftk-1.41.ebuild v1 2008/12/22 09:29:31 cJ Exp $

inherit eutils

DESCRIPTION="A tool for manipulating PDF documents"
HOMEPAGE="http://www.pdfhacks.com/pdftk"
SRC_URI="http://www.pdfhacks.com/pdftk/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
EAPI=2
RDEPEND="
"
DEPEND="
 dev-lang/perl
 || ( =sys-devel/gcc-3.3*[gcj] =sys-devel/gcc-3.4*[gcj] =sys-devel/gcc-4.2*[gcj] )
"

S=${WORKDIR}/${P}/${PN}

src_compile() {
	ebegin "Patching makefile to accept custom CFLAGS"
	perl -i.bak -p -e 's:-O2:\$(CFLAGS):g' ${S}/Makefile.Generic
	eend $?

	ebegin "Removing some java-config settings which break compilation by gcj"
	unset CLASSPATH
	unset JAVA_HOME
	eend 1

	make -f Makefile.Generic || die "Compilation failed."
}

src_install() {
	dobin pdftk
	newman ../pdftk.1.txt pdftk.1
	dohtml ../pdftk.1.html
}

