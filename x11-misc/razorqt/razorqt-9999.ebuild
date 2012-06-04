# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit cmake-utils eutils qt4 git-2

DESCRIPTION="advanced, easy-to-use, and fast desktop environment based on Qt technologies"
HOMEPAGE="http://razor-qt.org"
SRC_URI=""
EGIT_REPO_URI="git://github.com/Razor-qt/razor-qt.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

