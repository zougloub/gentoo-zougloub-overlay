# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils subversion

DESCRIPTION="BitTorrent Client using libtorrent"
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI=""
ESVN_REPO_URI="svn://rakshasa.no/libtorrent/trunk/rtorrent"
ESVN_REVISION="1105"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="daemon debug ipv6 xmlrpc"

COMMON_DEPEND="
 >=net-libs/libtorrent-${PV##*.}
 >=dev-libs/libsigc++-2.2.2:2
 >=net-misc/curl-7.19.1
 sys-libs/ncurses
 xmlrpc? ( dev-libs/xmlrpc-c )
"

RDEPEND="
 ${COMMON_DEPEND}
 daemon? ( app-misc/screen )
"

DEPEND="
 ${COMMON_DEPEND}
 dev-util/pkgconfig
"

src_prepare() {
	for file in dht-pex-static_map.diff magnet-uri.diff object-sstr.diff;
	do
		wget http://ovh.ttdpatch.net/~jdrexler/rt/experimental/$file
		patch --strip=1 --force < $file
	done
	for file in canvas-color.patch trackerinfo.patch;
	do
		wget http://www.simplylinux.ch/rtorrent/$file
		patch --strip=1 --force < $file
	done
	./autogen.sh
}

src_configure() {
	econf \
	 --disable-dependency-tracking \
	 $(use_enable debug) \
	 $(use_enable ipv6) \
	 $(use_with xmlrpc xmlrpc-c)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README TODO doc/rtorrent.rc

	if use daemon; then
		newinitd "${FILESDIR}/rtorrentd.init" rtorrentd || die "newinitd failed"
		newconfd "${FILESDIR}/rtorrentd.conf" rtorrentd || die "newconfd failed"
	fi
}

