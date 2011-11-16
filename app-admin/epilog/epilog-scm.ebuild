# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit eutils git-2 python

DESCRIPTION="A flexible syslog"
HOMEPAGE="http://zougloub.eu/wiki/perso/dev/epilog"
EGIT_PROJECT="epilog"
EGIT_REPO_URI="git://git.zougloub.eu/epilog"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"
PROVIDE="virtual/logger"

src_install() {
	dosbin epilog

	insinto /etc/
	doins epiconf.py

	newinitd epilog.initd epilog
	newconfd epilog.confd epilog
}

