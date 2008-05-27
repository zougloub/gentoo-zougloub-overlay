# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"
DESCRIPTION="bmeps converts various bitmap picture formats to eps"
HOMEPAGE="http://sourceforge.net/projects/bmeps"
SRC_URI="http://ovh.dl.sourceforge.net/sourceforge/bmeps/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE=""


RDEPEND="
	sys-libs/zlib
	media-libs/libpng
	media-libs/jpeg
	media-libs/netpbm
"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	#epatch ${FILESDIR}/gentoo.patch || die "patching failed"
}

src_compile() {
	cd  ${WORKDIR}/bmeps-1.2.7
	econf || die
	make || die
	#cd ${WORKDIR} && ./configure --prefix=/usr/ && 	make
}

src_install() {
	cd  ${WORKDIR}/bmeps-1.2.7
	dobin ${WORKDIR}/bmeps-1.2.7/bmeps || die "Can't dobin"
	insinto /usr/bin
#	doins ${WORKDIR}/${P}/bmeps.conf || die "Can't write to /etc"
	dodoc DOCU/* bsdlic.txt share/doc/bmeps.pdf
}

pkg_postinst() {
	einfo "Bon normalement c'est OK.."
	einfo " "
	ewarn "Attention c'est mon premier ebuild !!!"
	chmod a+x /usr/bin/bmeps
}

