# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils cmake-utils git

EAPI=2
EGIT_PROJECT="shake"
EGIT_REPO_URI="git://git.savannah.nongnu.org/shake.git"
DESCRIPTION="Defragmenter (rewrite fragmented or misplaced files)"
HOMEPAGE="http://vleu.net/shake/ http://savannah.nongnu.org/projects/shake"

LICENSE="GPL-2 FDL-1.2"
SLOT=0
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
DEPEND="sys-apps/attr"

src_prepare() {
	ebegin "Patching CMakeLists.txt"
	sed --in-place=.bak --expression='s/^cmake_policy(SET CMP0005 OLD)$/#cmake_policy(SET CMP0005 OLD)/' CMakeLists.txt || die "failed patching"
	eend $?
}

src_configure() {
	cmake .
}

src_compile() {
	default_src_compile
}

src_install() {
	dosbin shake
	dobin unattr
	doman doc/shake.8 doc/unattr.8
}
