# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
EGIT_REPO_URI="git://github.com/libgit2/libgit2.git"
EGIT_BRANCH="master"
inherit cmake-utils git

DESCRIPTION="Shared C library implementing Git"
HOMEPAGE="http://libgit2.github.com/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-util/cmake"
RDEPEND=""

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install
}
