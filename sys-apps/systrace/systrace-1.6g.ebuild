inherit eutils

DESCRIPTION="Interactive Policy Generation for System Calls"
HOMEPAGE="http://www.systrace.org/"
SRC_URI="http://www.provos.org/uploads/${P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="dev-libs/libevent"
DEPEND="$RDEPEND
	>=sys-devel/autoconf-2.58"

SYSTR_HEADER="${ROOT}usr/src/linux/include/linux/systrace.h"

src_unpack() {
	unpack ${A}
	cd ${S}

	if ! [ -f ${SYSTR_HEADER} ] ; then
		einfo
		einfo "${SYSTR_HEADER} not found. Using ptrace-based backend."
		einfo
		epatch "${FILESDIR}"/systrace-regress.patch
	else
		einfo
		einfo "${SYSTR_HEADER} found. Using /dev/systrace."
		einfo
	    sed -i -e "s/all:.\+/all:/" ./regress/Makefile.am
	    sed -i -e "s:linux\/systrace.h:${SYSTR_HEADER}:" ./configure
	    sed -i -e "s:<linux\/systrace.h>:\"${SYSTR_HEADER}\":" ./linux-syscalls.c
	fi

	epatch "${FILESDIR}/systrace-1.6g.patch"

	ebegin "Changing xsystrace path"
	sed -i.bak -e "s|/usr/X11R6/bin/xsystrace|/usr/bin/xsystrace|g" systrace.h
	eend $?

	export WANT_AUTOCONF=2.5
}

src_install() {
	dobin systrace || die
	doman systrace.1
}

