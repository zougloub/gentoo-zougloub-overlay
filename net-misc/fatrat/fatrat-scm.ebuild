# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils eutils qt4 git

EGIT_REPO_URI="git://git.dolezel.info/fatrat.git"
DESCRIPTION="Qt4-based download/upload manager"
HOMEPAGE="http://fatrat.dolezel.info/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+bittorrent +curl -debug doc jabber nls webinterface"

RDEPEND="
 ( x11-libs/qt-gui[dbus] x11-libs/qt-core[ssl] )
 bittorrent?
 (
  >=net-libs/rb_libtorrent-0.13_pre1683
  x11-libs/qt-webkit
 )
 curl? ( net-misc/curl )
 doc? ( x11-libs/qt-assistant )
 jabber? ( net-libs/gloox )
 webinterface? ( x11-libs/qt-webkit )
"
DEPEND="
 >=dev-util/cmake-2.6.0
 ${RDEPEND}
"

S="${WORKDIR}/${PN}"

pkg_setup() {
	qt4_pkg_setup
	if ! has_version dev-libs/geoip; then
		einfo "If you want the GeoIP support, then emerge dev-libs/geoip."
		einfo "Then GeoIP support will be available in the software"
		einfo " without rebuilding it"
	fi
}

src_prepare() {
	epatch $FILESDIR/typo.patch
}

src_configure() {
	local myconf=""
	use debug && myconf="-DCMAKE_BUILD_TYPE=Debug"
	cmake . \
		-DCMAKE_INSTALL_PREFIX="/usr" \
		$(cmake-utils_use_with bittorrent BITTORRENT) \
		$(cmake-utils_use_with curl CURL) \
		$(cmake-utils_use_with doc DOCUMENTATION) \
		$(cmake-utils_use_with jabber JABBER) \
		$(cmake-utils_use_with nls NLS) \
		$(cmake-utils_use_with webinterface WEBINTERFACE) \
		${myconf} || die "cmake failed"
}

src_compile() {
	default_src_compile
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

