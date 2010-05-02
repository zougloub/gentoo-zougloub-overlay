# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit distutils git

DESCRIPTION="console client for the xmms2 music player"
HOMEPAGE="http://palbo.github.com/ccx2/"
EGIT_REPO_URI="git://github.com/palbo/ccx2.git"
SRC_URI=""
LICENSE="BSD"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
RDEPEND="
 dev-python/lxml
 media-sound/xmms2[python]
"
DEPEND="
 $RDEPEND
"

