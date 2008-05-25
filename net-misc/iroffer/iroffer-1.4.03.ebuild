# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils versionator

# iroffer uses irofferX.Y.bZ.tgz
MY_PV=$( replace_version_separator 2 '.b' )
MY_P=${PN}${MY_PV}

DESCRIPTION="fileserver for IRC. It is similar to FTP server or WEB server, but uses the DCC protocol of IRC"
HOMEPAGE="http://iroffer.org/"
SRC_URI="http://iroffer.org/archive/v$( get_version_component_range 1-2 )/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="chroot"

DEPEND="chroot? ( dev-libs/nss )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${MY_P}.tgz
	cd ${S}
}

src_compile() {
	# iroffer configure script does not take ANY options
	./Configure
	emake || die "emake failed"
}

src_install() {
	# since iroffers configure and makefile suck
	# we copy everything by hand
	dobin convertxdccfile iroffer
	use chroot && dobin iroffer_chroot
	dodoc COPYING README WHATSNEW sample.config dynip.sh iroffer.cron
} 

