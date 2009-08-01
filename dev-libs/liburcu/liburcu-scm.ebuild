# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils git

EAPI=2
EGIT_PROJECT="userspace-rcu"
EGIT_REPO_URI="git://lttng.org/userspace-rcu.git"
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

#src_prepare() {
#	./autogen.sh || die "Autogen failed"
#}

#src_configure() {
#	econf $(use gnome && echo --with-gnome) || die "Configure failed"
#}

#src_compile() {
#	emake || die "Make failed"
#}

src_install() {
	dir="$IMAGE/usr/lib"
	mkdir -p "$dir"
	cp -f liburcu.so "$dir/"

	dir="$IMAGE/usr/include/liburcu"
	mkdir -p "$dir"
	cp -f arch.h arch_atomic.h compiler.h urcu.h urcu-static.h "$dir/"

	dir="$IMAGE/usr/libexec/liburcu"
	mkdir -p "$dir"
	for file in $(find -type f -executable -regex "^./test.*");
	do
		cp -f $file "$dir/"
	done
	cp -f urcutorture-yield urcutorture "$dir/"

	dodoc README
}
