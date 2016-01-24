# Copyright 2011-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Allows to mount 7-zip supported archives"
HOMEPAGE="http://github.com/exmakhina/fuse-7z"
SRC_URI="https://waf.io/waf-1.8.18"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
EGIT_REPO_URI="git://github.com/exmakhina/fuse-7z.git"

RESTRICT="primaryuri"

DEPEND="
"

RDEPEND="
 app-arch/p7zip
 ${DEPEND}
"

src_configure() {
	ln -sf $DISTDIR/$A waf
	python waf configure || die
}

src_compile() {
	python waf || die
}

src_install() {
	dobin wrapper/fuse-7z
	exeinto /usr/libexec/fuse-7z
	doexe build/fuse-7z
	dodoc README
}

