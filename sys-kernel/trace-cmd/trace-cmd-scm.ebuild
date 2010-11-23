# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils git

DESCRIPTION="command line reader for ftrace"
HOMEPAGE="http://lwn.net/Articles/341902/"
SRC_URI=""
EAPI=2

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gui +python"

DEPEND="
 gui? ( dev-lang/python )
 python? ( dev-lang/python dev-lang/swig )
"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/trace-cmd.git"
EGIT_BRANCH="master"

src_compile() {
	local target=all
	if use gui; then
		target="all gui"
	fi
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" $target || die
}

src_install() {
	local target=install
	if use gui; then
		target="install install_gui"
	fi
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
	 DESTDIR="${D}" prefix="/usr" $target || die
}
