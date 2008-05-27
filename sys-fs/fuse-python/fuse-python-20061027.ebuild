# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit python eutils
inherit distutils 

KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
DESCRIPTION="Python FUSE bindings"
HOMEPAGE="http://fuse.sourceforge.net/wiki/index.php/FusePython"
SRC_URI="http://dev.gentoo.org/~vivo/misc/${PN}-hg-${PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
IUSE=""
S="${WORKDIR}/${PN}-hg"

RDEPEND=">=dev-lang/python-2.3
		>=sys-fs/fuse-2.0"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
	cp -r example ${D}/usr/share/doc/${PF}/
}

