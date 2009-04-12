# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils subversion

DESCRIPTION="Network focused portable C++ class library providing high level functions"
HOMEPAGE="http://www.ekiga.org/"
ESVN_REPO_URI="https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/ptlib/trunk"
ESVN_PROJECT="ptlib"


LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="alsa bsdvideo debug doc esd ieee1394 ipv6 ldap minimal noaudio novideo oss sasl sdl ssl sunaudio v4l v4l2 xml"
S="$WORKDIR/$PN"

RDEPEND="alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	ieee1394? ( media-libs/libdv
		sys-libs/libavc1394
		media-libs/libdc1394:1 )
	ldap? ( net-nds/openldap )
	sasl? ( dev-libs/cyrus-sasl:2 )
	sdl? ( media-libs/libsdl )
	ssl? ( dev-libs/openssl )
	xml? ( dev-libs/expat )"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex
	v4l? ( sys-kernel/linux-headers )
	v4l2? ( sys-kernel/linux-headers )
	!dev-libs/pwlib"

src_unpack() {
	subversion_src_unpack
}

src_prepare() {
	#unpack ${A}
	cd "${S}"

	ebegin "Filtering out -O3, -Os and -mcpu embedded compiler flags"
	sed -i \
		-e "s:-mcpu=\$(CPUTYPE)::" \
		-e "s:-O3 -DNDEBUG:-DNDEBUG:" \
		-e "s:-Os::" \
		make/unix.mak \
		|| die "Patching make/unix.mak failed"
	eend $?
	
	# don't break make install if there are no plugins to install
	# epatch "${FILESDIR}"/${P}-instplugins.diff

	# this patch fixes bugs: #145424 and #140358
	# epatch "${FILESDIR}"/${P}-asm.patch
}

src_configure() {
	local myconf=""

	use noaudio && myconf="${myconf} --disable-audio"
	use novideo && myconf="${myconf} --disable-video"

	econf \
		${myconf} \
		$(use_enable alsa) \
		$(use_enable bsdvideo) \
		$(use_enable debug exceptions) \
		$(use_enable debug memcheck) \
		$(use_enable esd) \
		$(use_enable ieee1394 avc) \
		$(use_enable ieee1394 dc) \
		$(use_enable ipv6) \
		$(use_enable ldap openldap) \
		$(use_enable minimal minsize) \
		$(use_enable oss) \
		$(use_enable sasl) \
		$(use_enable sdl) \
		$(use_enable ssl openssl) \
		$(use_enable sunaudio) \
		$(use_enable v4l) \
		$(use_enable v4l2) \
		$(use_enable xml expat) \
		--enable-plugins \
		|| die "econf failed"

}

src_compile() {
	local makeopts=""
	if use debug; then
		makeopts="${makeopts} DEBUG=1 debug"
	fi

	emake ${makeopts} || die "emake failed"
}

src_install() {
	local makeopts

	makeopts="PREFIX=/usr DESTDIR=\"${D}\""

	if use debug; then
		makeopts="${makeopts} DEBUG=1"
	fi

	emake ${makeopts} install || die "emake install failed"

	if use doc; then
		dohtml -r html/* || die "documentation installation failed"
	fi

	dodoc ReadMe.txt ReadMe_QOS.txt History.txt || die "documentation installation failed"
}
