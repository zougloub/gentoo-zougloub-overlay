# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils git-2

EGIT_PROJECT="userspace-rcu"
EGIT_REPO_URI="git://git.lttng.org/userspace-rcu.git"
EGIT_TREE="master"
DESCRIPTION="Userspace RCU library"
HOMEPAGE="http://lttng.org"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="primaryuri"
SLOT="0"

RDEPEND="
"

DEPEND="${RDEPEND}
"

src_prepare() {
	default_src_prepare #./autogen.sh || die "Autogen failed"
}

src_configure() {
	default_src_configure
}

src_compile() {
	default_src_compile
}

src_install() {
	insinto /usr/lib
	doins liburcu.so

	insinto /usr/include/liburcu
	doins arch.h arch_atomic.h compiler.h urcu.h urcu-static.h

	insinto /usr/libexec/liburcu
	for file in $(find -type f -executable -regex "^./test.*");
	do
		doins $file
	done
	doins urcutorture-yield urcutorture

	dodoc README
}
