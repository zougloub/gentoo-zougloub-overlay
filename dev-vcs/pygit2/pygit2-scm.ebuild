# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
EGIT_REPO_URI="git://github.com/libgit2/pygit2.git"
PYTHON_DEPEND="2:2.6"
inherit distutils git python

DESCRIPTION="Python bindings for libgit2"
HOMEPAGE="http://libgit2.github.com/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-vcs/libgit2 dev-libs/openssl sys-libs/zlib"
RDEPEND=""

pkg_setup() {
	python_set_active_version 2
}

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
