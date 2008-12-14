# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ app-editors/gobby-scm.ebuild 2008/12/14 05:44:16 cJ Exp $

inherit git eutils

EGIT_PROJECT="gobby"
EGIT_REPO_URI="git://git.0x539.de/git/gobby.git"
EGIT_TREE="gobby-infinote"
DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"
RESTRICT="nomirror"
SLOT="0.5"

RDEPEND="
	=net-libs/libinfinity-scm
"

DEPEND="${RDEPEND}
	dev-util/git
"

src_unpack() {
	git_src_unpack
}

src_compile() {
	./autogen.sh || die "Autoconf failed"
	econf $(use gnome && echo --with-gnome) || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake install DESTDIR="$IMAGE/" || die "Could not install"
}
