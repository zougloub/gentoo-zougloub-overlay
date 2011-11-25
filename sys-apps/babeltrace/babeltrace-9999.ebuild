# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils git-2 autotools

DESCRIPTION="Tools for LTTng, linux tracer"
HOMEPAGE="http://lttng.org/lttng2.0"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="java"

DEPEND="
 dev-libs/liburcu
"

EGIT_REPO_URI="git://git.efficios.com/babeltrace.git"
EGIT_BRANCH="master"

src_prepare() {
	./bootstrap
	#eautoreconf
}

src_configure() {
	default_src_configure
}

src_compile() {
	default_src_compile
}

src_install() {
	default_src_install
	dodoc README ChangeLog
}

