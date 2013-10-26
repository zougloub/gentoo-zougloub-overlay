# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Interface to the wonderful Speex audio codec"
HOMEPAGE="http://freenet.mcnabhosting.com/python/pySpeex"
SRC_URI="http://freenet.mcnabhosting.com/python/pySpeex/$P.tar.gz"
RESTRICT=primaryuri
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"

DEPEND="
 >=dev-python/pyrex-0.9
"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

