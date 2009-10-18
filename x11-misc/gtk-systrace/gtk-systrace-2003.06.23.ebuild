EAPI=2

inherit eutils

DESCRIPTION="Interactive Policy Generation for System Calls - Graphical Front-end"
HOMEPAGE="http://www.systrace.org/"
SRC_URI="http://www.citi.umich.edu/u/provos/systrace/gtk-systrace-2003-06-23.tar.gz"
RESTRICT="primaryuri"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="
 >=x11-libs/gtk+-2.12.0:2
"
DEPEND="
 $RDEPEND
"

S="${WORKDIR}/notification-0.1"

src_prepare() {
	ebegin "Changing application name to gtk-systrace"
	sed -i.bak -e "s|notification|gtk-systrace|g" configure.in
	eend $?
}

src_install() {
	mv src/notification gtk-systrace
	dobin gtk-systrace
	dosym gtk-systrace /usr/bin/xsystrace
	insinto /usr/share/gtk-systrace
	mv notification.glade gtk-systrace.glade
	doins gtk-systrace.glade
	insinto /usr/share/gtk-systrace/pixmaps
	doins pixmaps/*
	dodoc AUTHORS NEWS README ChangeLog
}

