# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ net-libs/libinfinity-scm.ebuild 2008/12/14 05:44:16 cJ Exp $

inherit git eutils

EGIT_PROJECT="infinote"
EGIT_REPO_URI="git://git.0x539.de/git/infinote.git"
DESCRIPTION="libinfinity is an implementation of the Infinote protocol written in GObject-based C. "
HOMEPAGE="http://gobby.0x539.de/trac/wiki/Infinote/Libinfinity"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk +daemon +avahi"
RESTRICT="nomirror"

RDEPEND="
 net-libs/gnutls
 net-libs/libgsasl
 sys-libs/e2fsprogs-libs
 dev-libs/libgpg-error
 dev-libs/glib:2
 avahi? ( net-dns/avahi )
 gtk? ( >=dev-cpp/gtkmm-2.6 x11-libs/gtksourceview:2.0 )
 >=dev-libs/libsigc++-2.0
 >=dev-cpp/libxmlpp-2.6
 gnome? ( gnome-base/gnome-vfs )
"

DEPEND="${RDEPEND}
 >=dev-util/gtk-doc-1.0
"

src_unpack() {
	git_src_unpack
}

src_compile() {
	./autogen.sh || die "Autogen failed"
	econf \
	 $(use daemon && echo -n --with-infinoted || echo -n --without-infinoted) \
	 $(use avahi && echo -n --with-avahi) \
	 $(use gtk && echo -n --with-infgtk) \
	  || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake install DESTDIR="$IMAGE/" || die "Could not install"
}
