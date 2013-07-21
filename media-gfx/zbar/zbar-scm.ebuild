# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils mercurial autotools

DESCRIPTION="A comprehensive software suite for reading barcodes. Supports EAN/UPC, Code 128, Code 39, Interleaved 2 of 5 and QR Code"
HOMEPAGE="http://zbar.sourceforge.net"
SRC_URI=""

EHG_REPO_URI="http://zbar.hg.sourceforge.net:8000/hgroot/zbar/zbar"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="gtk +imagemagick +jpeg python qt4 +threads +v4l +v4l2 X +xv +doc"

DEPEND="
	gtk? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	imagemagick? ( >=media-gfx/imagemagick-6.2.6 )
	jpeg? ( virtual/jpeg )
	python? (
		>=dev-lang/python-2.3
		gtk? ( dev-python/pygtk )
	)
	qt4? ( dev-qt/qtcore:4 dev-qt/qtgui:4 )
	X? (
		x11-libs/libXext
		xv? ( x11-libs/libXv )
	)
	doc? ( app-doc/doxygen app-text/xmlto )
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_prepare() {
	eautoreconf
	touch doc/man/man.stamp.tmp
}

src_configure() {
	local conf
	if use v4l || use v4l2 ; then
		conf="${conf} --enable-video"
	else
		conf="${conf} --disable-video"
	fi

	econf ${conf} \
	 --docdir=/usr/share/doc/${PF} \
	 $(use_enable threads pthread) \
	 $(use_with jpeg) \
	 $(use_with gtk) \
	 $(use_with imagemagick) \
	 $(use_with python) \
	 $(use_with qt4 qt) \
	 $(use_with X x) \
	 $(use_with xv xv)
}

src_compile() {
	pushd doc
	ln -sf . doc
	doxygen doxygen.conf
	popd
	emake
}

src_install() {
	if use doc;
	then
		emake install DESTDIR="${D}" || die "einstall failed"
	else
		emake install DESTDIR="${D}"
	fi
	dodoc INSTALL COPYING.LIB TODO README NEWS HACKING
}

