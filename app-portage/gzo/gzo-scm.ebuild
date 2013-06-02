# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils git

EGIT_PROJECT="gzo"
EGIT_REPO_URI="git://git.zougloub.eu/gzo.git"
DESCRIPTION="Simple interface to the gentoo.zapto.org ebuild search engine in text mode"
HOMEPAGE="http://gentoo.zougloub.eu"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="nomirror"
SLOT="0"

RDEPEND="
 dev-lang/perl
 || (
  www-client/links
  www-client/w3m
  www-client/elinks
 )
"

DEPEND="${RDEPEND}
"

src_install() {
	dobin gzo
}
