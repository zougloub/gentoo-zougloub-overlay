# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2
inherit eutils libtool subversion

DESCRIPTION="LibTorrent is a BitTorrent library written in C++ for *nix."
HOMEPAGE="http://libtorrent.rakshasa.no/"
SRC_URI=""
ESVN_REPO_URI="svn://rakshasa.no/libtorrent/trunk/libtorrent"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug ipv6 ssl"

RDEPEND="
 >=dev-libs/libsigc++-2.2.2:2
 ssl? ( dev-libs/openssl )
"
DEPEND="
 ${RDEPEND}
 dev-util/pkgconfig
"

src_prepare() {
	#epatch "${FILESDIR}"/${P}-gcc44.patch
	#elibtoolize
	for file in dht-pex-static_map.diff magnet-uri.diff;
	do
		wget http://ovh.ttdpatch.net/~jdrexler/rt/experimental/$file
		#patch --strip=1 --force < $file
	done
	./autogen.sh
}

src_configure() {
	econf \
	 --disable-dependency-tracking \
	 --enable-aligned \
	 $(use_enable debug) \
	 $(use_enable ipv6) \
	 $(use_enable ssl openssl) \
	 --with-posix-fallocate
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README
}

