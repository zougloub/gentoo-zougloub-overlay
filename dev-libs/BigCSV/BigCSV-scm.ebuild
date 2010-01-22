# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

EGIT_REPO_URI="git://git.zougloub.eu/BigCSV"
inherit eutils git

DESCRIPTION="A library designed for handling big CSV data files"
HOMEPAGE="http://cJ.is-a-geek.org/wiki/perso/dev/bigcsv/"
SRC_URI=""

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="+doc"

DEPEND="
 dev-lang/python
 doc? ( app-doc/doxygen )
"

RDEPEND="
"

S=${WORKDIR}/${PN}

src_prepare() {
	wget http://waf.googlecode.com/files/waf
	chmod +x waf
}

src_configure() {
	./waf configure || die "Configure failed"
}

src_compile() {
	./waf build || die "Build failed"

	if use doc ; then
		doxygen || die "doxygen failed"
	fi
}

src_install () {
	insinto /usr/include/BigCSV
	doins include/BigCSV/CSV.hpp
	dolib build/default/lib* || die "could not install"
	if use doc ; then
		dohtml -r doc/html/* || die "installing docs failed"
	fi
}

