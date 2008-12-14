# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild come from http://forums.gentoo.org/viewtopic-t-410834.html - The site http://gentoo.zugaina.org/ only host a copy.
# Small modifications by Ycarus

inherit git eutils

EGIT_PROJECT="infinote"
EGIT_REPO_URI="git://git.0x539.de/git/infinote.git"
DESCRIPTION="libinfinity is an implementation of the Infinote protocol written in GObject-based C. "
HOMEPAGE="http://gobby.0x539.de/trac/wiki/Infinote/Libinfinity"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk daemon avahi"
RESTRICT="nomirror"

RDEPEND="
	net-libs/libgsasl
	$(use avahi && echo -n net-dns/avahi)
	$(use gtk && echo -n dev-cpp/gtkmm)
"

DEPEND="${RDEPEND}
	dev-util/git
"

src_unpack() {
	git_src_unpack
}

src_compile() {
	./autogen.sh || die "Autogen failed"
	econf \
	 $(use daemon && echo -n --with-infinoted) \
	 $(use avahi && echo -n --with-avahi) \
	 $(use gtk && echo -n --with-infgtk) \
	  || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	emake install DESTDIR="$IMAGE/" || die "Could not install"
}
