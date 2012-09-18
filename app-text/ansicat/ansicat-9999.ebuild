# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils git-2

DESCRIPTION="Converts ANSI terminal sequences to HTML"
HOMEPAGE="https://gitorious.org/ansicat/ansicat"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-3.0"
DEPEND="
$RDEPEND
"
RESTRICT="primaryuri"
EGIT_REPO_URI="git://gitorious.org/ansicat/ansicat.git"

src_install() {
	dobin ansicat ansi2html
}

