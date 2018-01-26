# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_{5,6,7},3_{4,5,6}} pypy{1_9,2_0} )

inherit mercurial distutils-r1

DESCRIPTION="Python implementation of Ditz (http://rubygems.org/gems/ditz)."
HOMEPAGE="http://pythonhosted.org/pyditz/"
SRC_URI="mirror://pypi/p/pyditz/pyditz-${PV}.tar.gz -> ${P}.tar.gz"

if [ "$PV" == "9999" ]; then
   EHG_REPO_URI="https://bitbucket.org/zondo/pyditz"
   SRC_URI=""
fi

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="
"
RDEPEND="
 dev-python/pyyaml
 dev-python/cerberus
"

if [ "$PV" == "9999" ]; then
	:
else
	S="${WORKDIR}/pyditz-${PV}"
fi

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}

