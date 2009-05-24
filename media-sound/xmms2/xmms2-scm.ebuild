EAPI=2

inherit eutils git toolchain-funcs

EGIT_REPO_URI="git://git.xmms.se/xmms2/xmms2-stable.git"
EGIT_TREE="master"
EGIT_PROJECT="xmms2-stable"

S="${WORKDIR}/${EGIT_PROJECT}"

DESCRIPTION="XMMS2 Git Version"
HOMEPAGE="http://wiki.xmms2.xmms.se/"
LICENSE="LGPL-2.1 / GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa jack oss java python ruby avahi vorbis wma mp3 aac flac gnome musepack samba modplug speex id3 daap curl sid ecore mms icecast"

RDEPEND="
 >=dev-libs/glib-2.6.0
 >=dev-db/sqlite-3.2.6
 dev-libs/boost
 aac? ( >=media-libs/faad2-2.0 )
 alsa? ( media-libs/alsa-lib )
 curl? ( >=net-misc/curl-7.11.2 )
 ecore? ( x11-libs/ecore )
 ruby? ( dev-lang/ruby )
 java? ( virtual/jdk )
 samba? ( net-fs/samba )
 python? ( >=dev-lang/python-2.2.1 >=dev-python/pyrex-0.9.3 )
 modplug? ( media-libs/libmodplug )
 musepack? ( media-libs/libmpcdec )
 vorbis? ( media-libs/libvorbis  media-libs/libogg )
 flac? ( media-libs/libvorbis >=media-libs/flac-1.1.2 )
 jack? ( >=media-sound/jack-audio-connection-kit-0.103.0 )
 mp3? ( media-libs/libmad )
 speex? ( >=media-libs/libogg-1.1 media-libs/speex )
 daap? ( >=media-libs/libopendaap-0.3.0 )	
 avahi? ( >=net-dns/avahi-0.6 )
 gnome? ( >=gnome-base/gnome-vfs-2.0 )
 sid? ( media-sound/sidplay media-libs/resid )
 wma? ( media-video/ffmpeg )
 mms? ( media-libs/libmms )
"

DEPEND="
 ${RDEPEND}
 dev-util/pkgconfig
 >=dev-python/pyrex-0.9
 dev-lang/perl
"
# >=dev-util/scons-0.96

DISABLE=""

src_unpack() {
	git_src_unpack
	cd "${S}"
	#sed -i -e "s:/lib:/$(get_libdir):g" SConstruct xmms2.pc.in xmmsenv.py
}

src_configure() {
	local u o
	for u in aac:faad alsa curl modplug flac \
		 jack mp3:mad musepack oss samba sid speex  \
                 vorbis daap id3:id3v2 wma mms \
		 icecast:icymetaint; #avahi:mdns java python gnome:gnomevfs ecore ruby
	do
		o=${u##*:} ; o=${o:-${u}}
		u=${u%%:*}
		case $DISABLE in 
			"")
			use ${u} || DISABLE="${o}"
			;;
			
			*)
			use ${u} || DISABLE="${DISABLE},${o}"
			;;
		esac
        done

	echo "Disabling: ${DISABLE}"
	./waf configure --destdir="${D}" --without-plugins=$DISABLE --with-mandir=/usr/share/man --prefix=/usr || die "Configure failed !"

}

src_compile() {
	ebegin "Guessing job number"
	echo $MAKEOPTS | perl -pe \
	'
		s/(-j\s*\d|--jobs=\d)/JOBS_OPTS="$1"/;
	' > job_opts
	. job_opts
	eend $?

	./waf $JOBS_OPTS || die "Compilation failed"
	# --progress
	
	echo \
	 CC=$(tc-getCC) \
	 CXX=$(tc-getCXX) \
	 CCFLAGS="${CFLAGS}" \
	 CXXFLAGS="${CXXFLAGS}" \
	 LINK=$(tc-getCC) \
	 CONFIG="yes"
}

src_install() {
	./waf install --destdir="${D}" || die "Install failed!"
	dodoc AUTHORS ChangeLog README
}
