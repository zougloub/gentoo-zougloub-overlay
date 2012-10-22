# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit git-2 python distutils

DESCRIPTION="python FUSE bindings using ctypes"
HOMEPAGE="https://github.com/terencehonles/fusepy"
SRC_URI=""
LICENSE="BSD"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""
RDEPEND="
"
DEPEND="
 $RDEPEND
"

EGIT_REPO_URI="git://github.com/terencehonles/fusepy.git"

