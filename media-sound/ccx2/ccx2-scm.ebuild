# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit distutils git-2

DESCRIPTION="console client for the xmms2 music player"
HOMEPAGE="http://palbo.github.com/ccx2/"
SRC_URI=""

LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"

EGIT_REPO_URI="git://github.com/palbo/ccx2.git"

IUSE=""
RDEPEND="
 dev-python/lxml
 media-sound/xmms2[python?]
"
DEPEND="
 $RDEPEND
"

