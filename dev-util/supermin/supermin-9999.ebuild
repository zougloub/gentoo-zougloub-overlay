# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="Tool for creating supermin appliances"
HOMEPAGE="http://people.redhat.com/~rjones/supermin/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/libguestfs/supermin.git"
EGIT_HAS_SUBMODULES=1

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
"
DEPEND="
 ${RDEPEND}
 dev-ml/findlib
 sys-libs/zlib[static-libs]
"

src_prepare() {
	./gnulib/gnulib-tool --update
	eautoreconf
}

src_configure() {
	default_src_configure
}

src_compile() {
	default_src_compile
}
src_install() {
	default_src_install
}

