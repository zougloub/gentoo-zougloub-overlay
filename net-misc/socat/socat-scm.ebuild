# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ net-misc/socat-scm.ebuild 2008/12/22 05:44:16 cJ Exp $

inherit git eutils

EGIT_PROJECT="socat"
EGIT_REPO_URI="git://repo.or.cz/socat.git"
#EGIT_TREE="gobby-infinote"
DESCRIPTION="Multipurpose relay : netcat++ (extended design, new implementation)"
HOMEPAGE="http://www.dest-unreach.org/socat/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
RESTRICT="nomirror"
SLOT="0"

IUSE="+ssl +readline -tcpd"

RDEPEND="
 ssl? ( >=dev-libs/openssl-0.9.6 )
 readline? ( >=sys-libs/ncurses-5.1 >=sys-libs/readline-4.1 )
 tcpd? ( sys-apps/tcp-wrappers )
 virtual/libc
"

DEPEND="
 ${RDEPEND}
 dev-util/git
"

src_unpack() {
	git_src_unpack
}

src_compile() {
	ewarn "You will need to read socat.yo because man and html are not generated in this version (would require a bunch of useless dependencies)"
	ebegin "Patching makefile to not build regular documentation..."
	perl -i.bak -p -e 's|^doc: doc/socat.1 doc/socat.html$|doc: doc/socat.yo|' Makefile.in
	perl -i.bak -p -e 's|^\t\$\(INSTALL\) -m 644 \$\(srcdir\)/doc/socat.1 \$\(DESTDIR\)\$\(MANDEST\)/man1/$||' Makefile.in
	perl -i.bak -p -e 's|^DOCFILES = (.*) doc/socat.1 doc/socat.html (.*)$|DOCFILES = $1 $2|' Makefile.in
	perl -i.bak -p -e 's|^install: progs \$\(srcdir\)/doc/socat.1|install: progs|' Makefile.in
	eend $?

	ebegin "Autoconf"
	autoconf || die "failed"
	eend $?

	econf \
	 $(use_enable ssl openssl) \
	 $(use_enable readline) \
	 $(use_enable ipv6 ip6) \
	 $(use_enable tcpd libwrap) \
	 || die "Configure failed"

	emake || die "Make failed"
}

src_test() {
        TMPDIR="${T}" make test || die 'self test failed'
}

src_install() {
	emake install DESTDIR=${D} || die "Could not make install"

        dodoc BUGREPORTS CHANGES DEVELOPMENT EXAMPLES FAQ FILES PORTING README SECURITY VERSION doc/socat.yo

        docinto examples
        dodoc *.sh

        dohtml doc/*.html doc/*.css
}
