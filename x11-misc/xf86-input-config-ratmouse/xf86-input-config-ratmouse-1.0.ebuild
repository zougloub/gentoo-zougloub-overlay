# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Configuration for Saitek R.A.T. mouse"
SRC_URI=""
LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"

RDEPEND=""
DEPEND=""
S="${WORKDIR}"

src_install() {
	insinto /usr/share/X11/xorg.conf.d
	doins ${FILESDIR}/*
}

