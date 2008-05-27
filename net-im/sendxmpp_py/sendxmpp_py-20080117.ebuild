
DESCRIPTION="Simple Python program which sends Jabber messages from command-line"
HOMEPAGE="http://Gentoo.zapto.org"
SRC_URI="http://Gentoo.zapto.org/progs-cJ/${P/_/.}"
RESTRICT="mirror"
LICENSE="AS-IS"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
RDEPEND="dev-lang/python"

src_unpack() {
	cp "$DISTDIR"/"$A" "$WORKDIR"
}

src_compile() {
	ebegin "Moving ${P/_/.} to ${PN/_/.} (very hard..)"
	mv "${P/_/.}" "${PN/_/.}"
	eend
}

src_install () {
	dobin sendxmpp.py
}
