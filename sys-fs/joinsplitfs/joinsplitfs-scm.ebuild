# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils subversion

DESCRIPTION="Two virtual FUSE filesystems to join or split files."
#SRC_URI="mirror://sourceforge/joinsplitfs/${PN}-v${PV}.tar.gz"
HOMEPAGE="http://joinsplitfs.sourceforge.net/"
LICENSE="GPL-3"

RDEPEND="
 >=sys-fs/fuse-2.7.1
"
DEPEND="
 ${RDEPEND}
 >=dev-util/pkgconfig-0.22
"

KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
EAPI=2

ESVN_REPO_URI="https://svn.sourceforge.net/svnroot/${PN}"

src_prepare() {
	cd "${WORKDIR}/${P}/trunk/src"
	./autotools.sh || die "preconf failed"
}

src_install() {
	cd "${WORKDIR}/${P}/trunk/src"
	dobin joinfs || die "Could not dobin joinfs binary"
	dobin splitfs || die "Could not dobin splitfs binary"
	#emake DESTDIR=${D} install || die "emake install failed"
	dodoc README ChangeLog NEWS
}

