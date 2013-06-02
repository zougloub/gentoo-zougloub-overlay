# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils git

EGIT_PROJECT="icmptx"
EGIT_REPO_URI="git://github.com/jakkarth/icmptx.git"
DESCRIPTION="IP-over-ICMP tunnel"
HOMEPAGE="http://github.com/jakkarth/icmptx/"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
RESTRICT="nomirror"
SLOT="0"

RDEPEND=""
DEPEND="
 ${RDEPEND}
"

src_install() {
	dosbin icmptx
	dodoc README
}
