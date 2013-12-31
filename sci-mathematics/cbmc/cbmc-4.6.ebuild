# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="Bounded Model Checker for ANSI-C and C++ programs"
HOMEPAGE="http://www.cprover.org/cbmc/"
SRC_URI="http://minisat.se/downloads/minisat-2.2.0.tar.gz"
ESVN_REPO_URI="http://www.cprover.org/svn/cbmc/releases/${P}"
RESTRICT="primaryuri"
LICENSE="CBMC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

src_unpack() {
	subversion_src_unpack || die
	default_src_unpack || die
}

src_prepare() {
	ln -sf ../minisat minisat-2.2.0
	pushd minisat-2.2.0
	patch -p1 < ${S}/scripts/minisat-2.2.0-patch
	popd
}

src_configure() {
	:
}

src_compile() {
	pushd src
	emake || die "emake failed"
	popd
}

src_install() {
	# TODO FIXME
	dobin src/cbmc/cbmc
	doman doc/man/*
}

