# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils cvs

DESCRIPTION="Converts simple .docx to text files"
HOMEPAGE="http://docx2txt.sourceforge.net/"
SRC_URI=""

ECVS_SERVER="docx2txt.cvs.sourceforge.net:/cvsroot/docx2txt"
ECVS_MODULE="docx2txt"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
"
RDEPEND="
 dev-lang/perl
 ${DEPEND}
"

S=$WORKDIR/docx2txt

src_compile() {
	echo -n ""
}

src_install() {
	dodoc README ChangeLog ToDo

	mv docx2txt.pl docx2txt
	dobin docx2txt || die "could not install docx2txt"
}

