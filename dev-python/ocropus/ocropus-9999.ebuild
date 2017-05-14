# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit git-r3 distutils-r1

DESCRIPTION="Collection of document analysis programs."
HOMEPAGE="https://github.com/tmbdev/ocropy"
SRC_URI="https://github.com/tmbdev/ocropy/archive/v${PV}.tar.gz"

if [ "$PV" == "9999" ]; then
   EGIT_REPO_URI="git://github.com/tmbdev/ocropy"
   SRC_URI=""
fi

LICENSE="Apache-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
"
RDEPEND="
"

