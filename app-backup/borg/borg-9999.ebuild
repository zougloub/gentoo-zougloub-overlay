# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_{2,3,4} )

inherit distutils-r1 git-r3

DESCRIPTION="Deduplicating backup program"
HOMEPAGE="https://borgbackup.github.io/"

if [ "$PV" == "9999" ]; then
	SRC_URI=""
else
	SRC_URI="https://pypi.python.org/packages/source/A/${PN}/${P}.tar.gz"
fi

EGIT_REPO_URI="https://github.com/borgbackup/borg.git"

RDEPEND="
 >=dev-python/msgpack-0.1.10
 >=dev-libs/openssl-1.0.0
 >=dev-python/llfuse-0.39
"

DEPEND="
 >=dev-python/cython-0.18.0
"

LICENSE="GPL"
KEYWORDS="~x86"
SLOT="0"

python_compile() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	local DOCS=( README.rst )
	distutils-r1_python_install_all
}

