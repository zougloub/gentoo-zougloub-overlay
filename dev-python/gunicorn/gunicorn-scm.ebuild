# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit python git distutils

#distutils

DESCRIPTION="Python WSGI HTTP Server for UNIX"
HOMEPAGE="http://gunicorn.org"
SRC_URI=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
EAPI="2"
IUSE=""
EGIT_REPO_URI="git://github.com/benoitc/gunicorn.git"

RDEPEND="
"

DEPEND="
 $RDEPEND
"

PYTHON_MODNAME="gunicorn"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

src_unpack() {
	git_src_unpack
}

src_install() {
	distutils_src_install
}

