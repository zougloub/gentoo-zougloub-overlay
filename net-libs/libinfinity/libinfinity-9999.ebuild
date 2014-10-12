# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ net-libs/libinfinity-scm.ebuild 2008/12/14 05:44:16 cJ Exp $

EAPI=3

inherit git-2

DESCRIPTION="libinfinity is an implementation of the Infinote protocol written in GObject-based C. "
HOMEPAGE="http://gobby.0x539.de/trac/wiki/Infinote/Libinfinity"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk +server avahi doc static-libs introspection"
RESTRICT="nomirror"

RDEPEND="
 >=dev-libs/glib-2.38
 dev-libs/libxml2
 >=net-libs/gnutls-2.12.0
 >=net-libs/libgsasl-0.2.21
 sys-libs/e2fsprogs-libs
 dev-libs/libgpg-error
 >=dev-libs/libsigc++-2.0
 >=dev-cpp/libxmlpp-2.6
 avahi? ( net-dns/avahi[gtk?] )
 gtk? ( dev-cpp/gtkmm:2.4 >=x11-libs/gtk+-3.12.0 x11-libs/gtksourceview:2.0 )
 introspection? ( >=dev-libs/gobject-introspection-1.0 )
"

DEPEND="${RDEPEND}
 dev-util/gtk-doc
"

EGIT_PROJECT="infinote"
EGIT_REPO_URI="git://github.com/gobby/libinfinity.git"

src_prepare() {
	./autogen.sh || die "Autogen failed"
}

src_configure() {
	econf \
	 $(use_with server infinoted) \
	 $(use_with avahi) \
	 $(use_with avahi libdaemon) \
	 $(use_with gtk infgtk) \
	 $(use_with gtk inftextgtk) \
	 $(use_enable static-libs static) \
	 $(use_enable introspection) \
	 $(use_enable doc gtk-doc) \
	  || die "Configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README.md TODO || die
}

