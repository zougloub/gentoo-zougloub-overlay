# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_2} pypy{1_9,2_0} )

inherit git-2 distutils-r1

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

python_pkg_setup() {
	:
}

