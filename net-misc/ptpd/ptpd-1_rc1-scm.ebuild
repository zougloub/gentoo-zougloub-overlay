# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

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
EAPI=2

ESVN_REPO_URI="https://svn.sourceforge.net/svnroot/${PN}/trunk"

S="${WORKDIR}/${PN}-1rc1"

src_compile() {
	cd src
	emake || die "emake failed"
}

src_install() {
	dodoc README RELEASE_NOTES doc/*
	doman src/ptpd.8 || die "Could not doman"
	dobin src/ptpd || die "Could not dobin"

}

