# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion

DESCRIPTION="Two virtual FUSE filesystems to join or split files."
#SRC_URI="mirror://sourceforge/joinsplitfs/${PN}-v${PV}.tar.gz"
HOMEPAGE="http://joinsplitfs.sourceforge.net/"
LICENSE="GPL-3"
RDEPEND=">=sys-fs/fuse-2.7.1"
DEPEND="${RDEPEND}
        >=dev-util/pkgconfig-0.22"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

ESVN_REPO_URI="https://svn.sourceforge.net/svnroot/${PN}"
# ESVN_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR-${DISTDIR}}/svn-src/"

#src_unpack() {
#        ESVN_UPDATE_CMD="svn update -N" 
#        ESVN_FETCH_CMD="svn checkout -N" 
#        ESVN_REPO_URI=`dirname ${ESVN_REPO_URI}` 
#        subversion_src_unpack
#
#        S=${WORKDIR}/${P}
#        cd ${S}
#}



src_compile() {
	cd "${WORKDIR}/${P}/trunk/src"
	./autotools.sh || die "preconf failed"
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	cd "${WORKDIR}/${P}/trunk/src"
	dobin joinfs || die "Could not dobin joinfs binary"
	dobin splitfs || die "Could not dobin splitfs binary"
	#emake DESTDIR=${D} install || die "emake install failed"
	dodoc README ChangeLog NEWS
}

