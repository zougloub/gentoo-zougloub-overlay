# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Protocol decoder lib"
HOMEPAGE="http://sigrok.org"
SRC_URI=""

EGIT_REPO_URI="git://sigrok.org/libsigrokdecode"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
"

RDEPEND="$DEPEND"

RESTRICT="primaryuri"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf
}

src_compile() {
	default_src_compile
}

