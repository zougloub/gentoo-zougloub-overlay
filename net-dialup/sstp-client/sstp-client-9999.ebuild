# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A client implementation of Secure Socket Tunneling Protocol (SSTP) for Linux / Mac OS-X that allows remote access via SSTP VPN to Microsoft Windows 2008 Server."
HOMEPAGE="http://sourceforge.net/projects/sstp-client/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

RESTRICT="primaryuri"

inherit autotools subversion

ESVN_REPO_URI="https://sstp-client.svn.sourceforge.net/svnroot/sstp-client/trunk"

src_install() {
	emake install DESTDIR="${D}"
}

