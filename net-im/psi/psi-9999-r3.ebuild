# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils qt4 subversion

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"

ESVN_REPO_URI="http://svn.psi-im.org/${PN}/trunk"
ESVN_PATCHES="${FILESDIR}/*.diff"

IUSE="crypt doc kernel_linux spell ssl xscreensaver"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="$(qt4_min_version 4.2.3)
	=app-crypt/qca-2*
	media-libs/libpng
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

QT4_BUILT_WITH_USE_CHECK="qt3support"

src_compile() {
	local rev=`svnversion ${PORTAGE_ACTUAL_DISTDIR}/svn-src/${PN}/trunk`
	sed -i "s/\"0\.12-dev\"/\"0.12-dev-r${rev}\"/" "${S}/src/applicationinfo.cpp"
	sed -i "s/\"0\.12-dev-rev1\"/\"0.12-dev-r${rev}\"/" "${S}/src/applicationinfo.cpp"

	# disable growl as it is a mac osx extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca --disable-plugins"
	use kernel_linux || myconf="${myconf} --disable-dnotify"
	use spell || myconf="${myconf} --disable-aspell"
	use xscreensaver || myconf="${myconf} --disable-xss"

	# cannot use econf because of non-standard configure script
	./configure ${myconf} || die "configure failed"

	cd ${S} && eqmake4 ${PN}.pro

	SUBLIBS="-L/usr/$(get_libdir)/qca2" emake || die "emake failed"

	if use doc; then
		cd doc
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	INSTALL_ROOT="${D}" emake install || die "emake install failed"

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster
	newdoc iconsets/system/README README.system
	newdoc certs/README README.certs
	dodoc README

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi
}
