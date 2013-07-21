# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit git-2 python distutils

DESCRIPTION="Python script that takes screenshots (browsershots) using webkit"
HOMEPAGE="https://github.com/AdamN/python-webkit2png/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/AdamN/python-webkit2png.git"

LICENSE="GPL"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
RDEPEND="
 dev-python/PyQt4
 dev-qt/qtwebkit:4
"

src_install() {
	distutils_src_install
	mv webkit2png.py webkit2png
	dobin webkit2png
}

