# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit subversion distutils-r1

DESCRIPTION="libtiff wrapper for Python"
HOMEPAGE="https://code.google.com/p/pylibtiff/"
SRC_URI=""

ESVN_REPO_URI="http://pylibtiff.googlecode.com/svn/trunk"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
 >=media-libs/tiff-4.0.0
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

