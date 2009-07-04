# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils git

DESCRIPTION="A highly configurable replacement for syslogd/klogd (zougloub version)"
HOMEPAGE="http://metalog.sourceforge.net/"
EGIT_PROJECT="metalog"
EGIT_REPO_URI="git://git.zougloub.eu/metalog"
EGIT_TREE="cJ"
EGIT_BRANCH="cJ"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/libpcre-3.4"
DEPEND="${RDEPEND}"
PROVIDE="virtual/logger"

EAPI="2"


src_prepare() {
	./autogen.sh || die "Autoconf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS metalog.conf

	into /usr/
	dosbin "${FILESDIR}/consolelog.sh" || die
	dosbin "${FILESDIR}/metalog-net" || die
	dobin "${FILESDIR}/metalog-console" || die

	newinitd "${FILESDIR}"/metalog.initd metalog
	newconfd "${FILESDIR}"/metalog.confd metalog
}

pkg_preinst() {
	if [[ -d "${ROOT}"/etc/metalog ]] && [[ ! -e "${ROOT}"/etc/metalog.conf ]] ; then
		mv -f "${ROOT}"/etc/metalog/metalog.conf "${ROOT}"/etc/metalog.conf
		rmdir "${ROOT}"/etc/metalog
		export MOVED_METALOG_CONF=true
	else
		export MOVED_METALOG_CONF=false
	fi
}

pkg_postinst() {
	if ${MOVED_METALOG_CONF} ; then
		ewarn "The default metalog.conf file has been moved"
		ewarn "from /etc/metalog/metalog.conf to just"
		ewarn "/etc/metalog.conf.  If you had a standard"
		ewarn "setup, the file has been moved for you."
	fi
}
