# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ net-libs/libinfinity-scm.ebuild 2008/12/14 05:44:16 cJ Exp $

EAPI=2

inherit git eutils

EGIT_PROJECT="infinote"
EGIT_REPO_URI="git://git.0x539.de/git/infinote.git"
DESCRIPTION="libinfinity is an implementation of the Infinote protocol written in GObject-based C. "
HOMEPAGE="http://gobby.0x539.de/trac/wiki/Infinote/Libinfinity"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gtk +server +avahi doc static-libs"
RESTRICT="nomirror"

RDEPEND="
 >=dev-libs/glib-2.0
 dev-libs/libxml2
 net-libs/gnutls
 net-libs/libgsasl
 sys-libs/e2fsprogs-libs
 dev-libs/libgpg-error
 >=dev-libs/libsigc++-2.0
 >=dev-cpp/libxmlpp-2.6
 avahi? ( net-dns/avahi )
 gtk? ( >=dev-cpp/gtkmm-2.6 >=x11-libs/gtksourceview-2.0 )
 gnome? ( gnome-base/gnome-vfs )
"

DEPEND="${RDEPEND}
 doc? ( dev-util/gtk-doc )
"

src_unpack() {
	git_src_unpack
}

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
	 $(use_enable doc gtk-doc) \
	  || die "Configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README TODO || die

	if use server; then
		newinitd "${FILESDIR}/infinoted.initd" infinoted
		newconfd "${FILESDIR}/infinoted.confd" infinoted

		keepdir /var/lib/infinote
		fowners infinote:infinote /var/lib/infinote
		fperms 770 /var/lib/infinote

		dosym /usr/bin/infinoted-${MY_PV} /usr/bin/infinoted

		elog "Add local users who should have local access to the documents"
		elog "created by infinoted to the infinote group."
		elog "The documents are saved in /var/lib/infinote per default."
	fi
}

