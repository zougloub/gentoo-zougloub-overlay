# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 git-r3

EGIT_REPO_URI="git://github.com/knorrie/python-btrfs"

DESCRIPTION="Python Btrfs module"
HOMEPAGE="https://github.com/knorrie/python-btrfs"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}"

