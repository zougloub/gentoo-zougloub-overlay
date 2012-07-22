# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils subversion

DESCRIPTION="Implementation of the Precision Time Protocol used to synchronize LANs precisely"
HOMEPAGE="http://ptpd.sourceforge.net"
LICENSE="BSD"
RDEPEND=""
DEPEND="${RDEPEND}
       "
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
ESVN_REPO_URI="https://ptpd.svn.sourceforge.net/svnroot/ptpd/trunk"

S="${WORKDIR}/${PN}"

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dodoc README RELEASE_NOTES doc/*
	dodoc -r tools
	doman src/ptpd.8 || die "Could not doman"
	dobin src/ptpd || die "Could not dobin"
}

