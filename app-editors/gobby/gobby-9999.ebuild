# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit git-2 gnome2-utils eutils

DESCRIPTION="GTK-based collaborative editor"
HOMEPAGE="http://gobby.0x539.de"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="avahi gnome doc +nls"
RESTRICT="nomirror"
SLOT="0.5"

EGIT_PROJECT="gobby"
EGIT_REPO_URI="git://git.0x539.de/git/gobby.git"

RDEPEND="
 =net-libs/libinfinity-9999[avahi=]
 dev-cpp/glibmm:2
 dev-cpp/gtkmm:2.4
 x11-libs/gtksourceview:2.0
 >=dev-libs/libsigc++-2.0
 >=dev-cpp/libxmlpp-2.6
"

DEPEND="
 ${RDEPEND}
 dev-util/pkgconfig
 doc? (
  app-text/gnome-doc-utils
  app-text/scrollkeeper
 )
 nls? ( >=sys-devel/gettext-0.12.1 )
"

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf \
	 $(use gnome && echo --with-gnome) \
	 $(use_enable nls) \
	 || die "Configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	domenu contrib/gobby-0.5.desktop
	doicon gobby-0.5.xpm
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}

