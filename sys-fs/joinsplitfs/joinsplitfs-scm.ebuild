# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit subversion eutils

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

ESVN_REPO_URI="https://svn.sourceforge.net/svnroot/${PN}/trunk"

S="$WORKDIR/$P/trunk"
PARENT=notyet

src_prepare() {
	PARENT="$S"
	S="$S/src"
	cd $S
	echo $PWD >&2
	./autotools.sh || die "preconf failed"
}

src_install() {
	dobin joinfs || die "Could not dobin joinfs binary"
	dobin splitfs || die "Could not dobin splitfs binary"
	dodoc NEWS TODO ChangeLog AUTHORS
	cd "$PARENT"
	dodoc README
}
