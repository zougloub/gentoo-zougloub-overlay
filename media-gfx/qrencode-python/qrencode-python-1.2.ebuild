# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit distutils-r1 vcs-snapshot

DESCRIPTION="A simple wrapper for the C qrencode library"
HOMEPAGE="https://pypi.python.org/pypi/qrencode/ https://github.com/Arachnid/pyqrencode/"
SRC_URI="https://github.com/Arachnid/pyqrencode/tarball/b75219e878f9913514d2f6c0438aaa3e37433382 -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="Apache-2.0"
IUSE=""

RDEPEND="
 dev-python/pillow[${PYTHON_USEDEP}]
 media-gfx/qrencode
"
DEPEND="${RDEPEND}"

