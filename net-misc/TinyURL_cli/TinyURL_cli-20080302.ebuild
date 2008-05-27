DESCRIPTION="Simple shell program which uses TinyURL service to make a tiny URL from its argument"
HOMEPAGE="http://Gentoo.zapto.org"
SRC_URI="http://Gentoo.zapto.org/progs-cJ/TinyURL-${PV}"
RESTRICT="primaryuri"
LICENSE="AS-IS"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
RDEPEND="net-misc/wget sys-apps/sed sys-apps/coreutils"

src_unpack() {
	cp "$DISTDIR"/"$A" "$WORKDIR"
}

src_compile() {
	ebegin "Moving ${A} to ${PN/_cli/} (very hard..)"
	mv "${A}" "${PN/_cli/}"
	eend
}

src_install () {
	dobin ${PN/_cli/}
}
