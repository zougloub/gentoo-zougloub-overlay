# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils subversion

DESCRIPTION="software library that enables programs to read and write Data Matrix (or DataMatrix) 2D barcodes"
HOMEPAGE="http://www.libdmtx.org/"
SRC_URI=""

ESVN_REPO_URI="https://libdmtx.svn.sourceforge.net/svnroot/libdmtx/trunk"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

src_prepare() {
	./autogen.sh
	return
}

src_install() {
	emake install DESTDIR="${D}"
	return
}
