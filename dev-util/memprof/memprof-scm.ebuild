# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils git

DESCRIPTION="Tool for profiling memory usage and finding memory leaks"
HOMEPAGE="http://www.secretlabs.de/projects/memprof/"
EGIT_PROJECT="memprof"
EGIT_REPO_URI="git://gitorious.org/memprof/memprof.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"


src_prepare() {
	./autogen.sh
}

src_install() {
	emake install DESTDIR="${D}" || die "einstall failed"
}
