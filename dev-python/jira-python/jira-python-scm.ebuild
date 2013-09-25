# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

DESCRIPTION="Python bindings to JIRA"
HOMEPAGE="http://jira-python.readthedocs.org"
SRC_URI=""
#S="$WORKDIR/$MY_PN-$PV"

EGIT_REPO_URI="https://bitbucket.org/bspeakmon/jira-python.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64 ~amd64-linux ~x86-linux"
IUSE="examples"

inherit distutils-r1 git

src_prepare() {
	einfo "Don't install documentation and examples in site-packages"
	#sed -e "/packages/,+1d" -i setup.py || die
	rm -rf tests tools || die
}

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	#local HTML_DOCS=( HISTORY.html xlwt/doc/xlwt.html )
	use examples && local EXAMPLES=( examples )
	distutils-r1_python_install_all

	#dodoc -r tests
	#docompress -x /usr/share/doc/${PF}/tests
}
