EAPI=5

#if LIVE
EGIT_REPO_URI="
 git://github.com/lvc/${PN}.git
 http://github.com/lvc/${PN}.git
"

inherit git-r3
#endif

DESCRIPTION="A tool for checking backward compatibility of a C/C++ library"
HOMEPAGE="http://ispras.linuxbase.org/index.php/API_Sanity_Checker"
SRC_URI="mirror://github/lvc/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 >=dev-util/abi-compliance-checker-1.98.7
 >=dev-util/ctags-5.5
"

#if LIVE
SRC_URI=
KEYWORDS=
#endif

src_install() {
	mkdir -p "${D}"/usr || die
	perl Makefile.pl --install --prefix=/usr --destdir="${D}" || die
}

