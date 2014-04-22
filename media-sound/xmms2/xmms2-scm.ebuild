# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs waf-utils git-r3

DESCRIPTION="X(cross)platform Music Multiplexing System. The new generation of the XMMS player."
HOMEPAGE="http://xmms2.xmms.org"

EGIT_REPO_URI="git://git.xmms2.org/xmms2/xmms2-devel.git"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="aac alsa ao +asx +avcodec cdda clientonly coreaudio curl +cpp daap
+diskwrite -ecore eq fam flac jack +lastfm mac mms modplug mp3 mp4 musepack
+nophonehome ofa oss perl python rss ruby samba shout sid speex test vorbis wma xml +xspf"

RESTRICT="mirror"

DEPEND="
 dev-util/cunit
 !clientonly? (
  >=dev-db/sqlite-3.3.4
  aac? ( >=media-libs/faad2-2.0 )
  alsa? ( media-libs/alsa-lib )
  ao? ( media-libs/libao )
  cdda? (
   >=media-libs/libdiscid-0.1.1
   >=media-sound/cdparanoia-3.9.8
  )
  curl? (
   >=net-misc/curl-7.15.1
   !=net-misc/curl-7.16.1
   !=net-misc/curl-7.16.2
  )
  flac? ( media-libs/flac )
  jack? ( >=media-sound/jack-audio-connection-kit-0.101.1 )
  mms? ( media-video/ffmpeg
   >=media-libs/libmms-0.3
  )
  modplug? ( media-libs/libmodplug )
  mp3? ( media-sound/madplay )
  mp4? ( media-video/ffmpeg )
  ofa? ( media-libs/libofa )
  rss? ( dev-libs/libxml2 )
  samba? ( net-fs/samba )
  sid? ( media-sound/sidplay
   media-libs/resid
  )
  speex? ( media-libs/speex )
  vorbis? ( media-libs/libvorbis )
  xml? ( dev-libs/libxml2 )
  xspf? ( dev-libs/libxml2 )
 )
 >=dev-lang/python-2.4.3
 >=dev-libs/glib-2.12.9
 cpp? ( >=dev-libs/boost-1.32 )
 ecore? ( x11-libs/ecore )
 fam? ( app-admin/gamin )
 perl? ( >=dev-lang/perl-5.8.8 )
 python? ( >=dev-python/pyrex-0.9.5.1 )
 ruby? ( >=dev-lang/ruby-1.8.5 )
 mac? ( media-sound/mac )
"

RDEPEND="${DEPEND}"

src_prepare() {
	cd "$S"
	git submodule update --init
}

src_configure() {
	local exc=""
	local excl_pls=""
	local excl_opts=",vistest"
	local options="--conf-prefix=/etc --prefix=/usr --destdir=${D}"
	if use clientonly ; then
		exc="--without-xmms2d=1 "
	else
		for x in cpp:xmmsclient++,xmmsclient++-glib ecore:xmmsclient-ecore fam:medialib-updater nophonehome:et perl python ruby test:tests ; do
			use ${x/:*} || excl_opts="${excl_opts},${x/*:}"
		done
		for x in aac:faad alsa ao asx avcodec cdda coreaudio curl daap diskwrite eq:equalizer flac jack lastfm mac mp3:mad mp4 mms modplug musepack ofa oss rss samba sid speex vorbis xml xspf ; do
			use ${x/:*} || excl_pls="${excl_pls},${x/*:}"
		done
	fi

	if [ ${excl_pls} != "" ]
	then
		options="${options} --without-plugins=${excl_pls:1}"
	fi
	if [ ${excl_opts} != "" ]
	then
		options="${options} --without-optionals=${excl_opts:1}"
	fi

	export \
	 CC="$(tc-getCC) ${CFLAGS} -fPIC" \
	 CXX="$(tc-getCXX) ${CXXFLAGS} -fPIC" \
	 LINK="$(tc-getCXX) ${LDFLAGS} -fPIC" \
	 PYTHON=python2

	waf-utils_src_configure $options $exc
}

src_install() {
	waf-utils_src_install || die
	dodoc AUTHORS TODO README
}

pkg_postinst() {
	if ! use nophonehome ; then
		einfo ""
		einfo "The phone-home client xmms2-et was activated"
		einfo "This client sends anonymous usage-statistics to the xmms2"
		einfo "developers which may help finding bugs"
		einfo "Enable the nophonehome useflag if you don't like that"
	fi
}
