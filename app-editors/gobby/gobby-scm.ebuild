# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils git

EAPI=2
EGIT_PROJECT="gobby"
EGIT_REPO_URI="git://git.0x539.de/git/gobby.git"
EGIT_TREE="gobby-infinote"
EGIT_BRANCH="gobby-infinote"
DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"
RESTRICT="nomirror"
SLOT="0.5"

RDEPEND="
 =net-libs/libinfinity-scm
 >=dev-cpp/gtkmm-2.6
 x11-libs/gtksourceview:2.0
 >=dev-libs/libsigc++-2.0
 >=dev-cpp/libxmlpp-2.6
"

DEPEND="${RDEPEND}
"

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf $(use gnome && echo --with-gnome) || die "Configure failed"
}

#src_compile() {
#	emake || die "Make failed"
#}

src_install() {
	emake install DESTDIR="$D" || die "Could not install"
}
