# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit git-2 distutils-r1

DESCRIPTION="library that can read and write Password Safe v3 files"
HOMEPAGE="https://github.com/ronys/pypwsafe"
SRC_URI=""

EGIT_REPO_URI="git://github.com/ronys/pypwsafe.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
 >=dev-python/python-mcrypt-1.0:0
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	local DOCS=( README.md )
	distutils-r1_python_install_all
}

