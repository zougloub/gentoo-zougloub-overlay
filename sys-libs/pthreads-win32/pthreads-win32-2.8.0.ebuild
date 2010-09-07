inherit eutils

EAPI="2"

DESCRIPTION="Provides the pthreads API on windows"
HOMEPAGE="http://sourceware.org/pthreads-win32/"
SRC_URI="ftp://sourceware.org/pub/pthreads-win32/pthreads-w32-2-8-0-release.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RESTRICT="primaryuri"

RDEPEND="
 ${CATEGORY}/w32api
"

DEPEND="
 ${CATEGORY}/gcc
"

src_prepare() {
	case $CATEGORY in
		cross-*mingw32*)
		;;
		*)
		die "This package should only be used in cross-*mingw32* categories !"
		;;
	esac
}

src_compile() {
	cd pthreads-w32-*-release
	emake CROSS="${CATEGORY/cross-/}-" clean GC-inlined || die "emake failed"
}

src_install() {
	PREFIX="/usr/${CATEGORY/cross-/}/usr"
	DP="${D}/${PREFIX}"
	cd pthreads-w32-*-release
	mkdir -p "${DP}/include" "${DP}/bin" "${DP}/lib" \
	 && cp pthread.h sched.h semaphore.h "${DP}/include/" \
	 &&	cp pthreadGC2.dll "${DP}/bin/" \
	 && cp libpthreadGC2.a "${DP}/lib/" \
	 && dosym pthreadGC2.dll "${PREFIX}/bin/pthread.dll" \
	 && dosym libpthreadGC2.a "${PREFIX}/lib/libpthread.a" \
	 || die "install failed"
	dodoc COPYING COPYING.LIB PROGRESS MAINTAINERS NEWS ANNOUNCE BUGS ChangeLog CONTRIBUTORS WinCE-PORT README*
}
