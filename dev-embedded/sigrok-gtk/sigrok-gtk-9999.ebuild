# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Sigrok GTK UI"
HOMEPAGE="http://sigrok.org"
SRC_URI=""

EGIT_REPO_URI="git://sigrok.org/sigrok-gtk"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+decode"

DEPEND="
 >=dev-embedded/libsigrok-9999
 decode? ( >=dev-embedded/libsigrokdecode-9999 )
"
RDEPEND="$DEPEND"

RESTRICT="primaryuri"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable decode libsigrokdecode)
}

src_compile() {
	default_src_compile
}

