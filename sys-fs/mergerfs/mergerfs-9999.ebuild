# Copyright 2011-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Another (FUSE based) union filesystem"
HOMEPAGE="https://github.com/trapexit/mergerfs"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
EGIT_REPO_URI="git://github.com/trapexit/mergerfs"

RESTRICT="primaryuri"

DEPEND="
"

RDEPEND="
 ${DEPEND}
"

src_install() {
	dobin mergerfs
	dodoc README.md
	doman man/mergerfs.1
}

