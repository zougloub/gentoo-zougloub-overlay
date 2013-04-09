# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit qt4-r2 eutils git-2

DESCRIPTION="nCommand line UI"
HOMEPAGE="http://sigrok.org"
SRC_URI=""

EGIT_REPO_URI="git://sigrok.org/sigrok-qt"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+decode"

DEPEND="
 >=dev-embedded/libsigrok-9999
 decode? ( >=dev-embedded/libsigrokdecode-9999 )
 dev-qt/qtgui:4
"
RDEPEND="$DEPEND"

RESTRICT="primaryuri"

src_configure() {
	qt4-r2_src_configure
}

src_compile() {
	qt4-r2_src_compile
}

