# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Source code line counter"
HOMEPAGE="http://labs.ohloh.net/ohcount"
SRC_URI=""
EGIT_REPO_URI="git://github.com/blackducksw/ohcount.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

# TODO RUBY dev-lang/swig
RDEPEND="
 dev-util/ragel
 dev-libs/libpcre
"
DEPEND="${RDEPEND}"

src_compile() {
    # TODO RUBY ./build ruby
    ./build ohcount || die './build failed'
}

src_install() {
    dobin bin/ohcount || die 'dobin failed'
}

