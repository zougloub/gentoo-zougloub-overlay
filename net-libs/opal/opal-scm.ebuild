# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils subversion

DESCRIPTION="C++ class library normalising numerous telephony protocols"
HOMEPAGE="http://www.ekiga.org"
ESVN_REPO_URI="https://opalvoip.svn.sourceforge.net/svnroot/opalvoip/opal/trunk"
ESVN_PROJECT="opal"


LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug doc java"

RDEPEND="=dev-libs/ptlib-scm[debug=]
	>=media-video/ffmpeg-0.4.7
	media-libs/speex
	java? ( virtual/jdk )"

S="$WORKDIR/$PN"

src_unpack() {
	subversion_src_unpack
}

src_configure() {
	#cd "${S}"

	# zrtp doesn't depend on net-libs/libzrtpcpp but on libzrtp from
	# http://zfoneproject.com/ that is not in portage
	econf \
		$(use_enable debug) \
		$(use_enable java) \
		--enable-plugins \
		--disable-localspeex \
		--disable-zrtp \
		|| die "econf failed"
	#epatch "${FILESDIR}"/${P}-lpcini.patch
}

src_compile() {
	local makeopts

	if use debug; then
		makeopts="debug"
	else
		makeopts="opt"
	fi

	emake ${makeopts} || die "emake failed"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${D}" install || die "emake install failed"

	if use doc; then
		dohtml -r html/* docs/* || die "documentation installation failed"
	fi
}
