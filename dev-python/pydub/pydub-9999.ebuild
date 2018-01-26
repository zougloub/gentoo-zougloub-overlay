# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/jiaaro/pydub"

DESCRIPTION="Manipulate audio with a simple and easy high level interface"
HOMEPAGE="http://github.com/jiaaro/pydub"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}"
