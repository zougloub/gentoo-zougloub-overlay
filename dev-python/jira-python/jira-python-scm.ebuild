# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

DESCRIPTION="Python bindings to JIRA"
HOMEPAGE="http://jira-python.readthedocs.org"
SRC_URI=""
EGIT_REPO_URI="https://bitbucket.org/bspeakmon/jira-python.git"

LICENSE="BSD"
SLOT=0
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64 ~amd64-linux ~x86-linux"
IUSE="examples"

# tlslite is for jirashell
RDEPEND="
 >=dev-python/tlslite-0.4
 >=dev-python/requests-1.0.0
 >=dev-python/oauthlib-0.5
 >=dev-python/requests-oauthlib-0.3.0
"

inherit distutils-r1 git-r3

src_prepare() {
	einfo "Don't install documentation and examples in site-packages"
	rm -rf tests tools || die
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	use examples && local EXAMPLES=( examples )
	distutils-r1_python_install_all
}
