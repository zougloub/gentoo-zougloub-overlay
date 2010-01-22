# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PV=${PV/_/.}
MY_P="${PN}${MY_PV}"

DESCRIPTION="Source code line counter"
HOMEPAGE="http://labs.ohloh.net/ohcount"
SRC_URI="http://d10xg45o6p6dbl.cloudfront.net/projects/o/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# TODO RUBY dev-lang/swig
RDEPEND="dev-util/ragel
    dev-libs/libpcre"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_compile() {
    # TODO RUBY ./build ruby
    ./build ohcount || die './build failed'
}

src_install() {
    dobin bin/ohcount || die 'dobin failed'
}
