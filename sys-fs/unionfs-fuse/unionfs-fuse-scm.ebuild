# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2
DESCRIPTION="Self-syncing tree-merging file system based on FUSE"

HOMEPAGE="http://podgorny.cz/moin/UnionFsFuse"
SRC_URI=""

inherit eutils mercurial

EHG_REPO_URI="http://hg.podgorny.cz/unionfs-fuse"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-fs/fuse"
RDEPEND="${DEPEND}"

S="$WORKDIR/unionfs-fuse"

src_compile() {
	einfo $PWD
	emake || die "make failed"
}

src_install() {
	dodir /usr/sbin /usr/share/man/man8/ || die "dodir failed"
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake failed"
	dodoc examples/* NEWS CREDITS
}

