EAPI=5

inherit git-r3

DESCRIPTION="Source code line counter"
HOMEPAGE="http://labs.ohloh.net/ohcount"
SRC_URI=""
EGIT_REPO_URI="git://github.com/blackducksw/ohcount.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
USE=""

# TODO RUBY dev-lang/swig
RDEPEND="
 >=dev-util/ragel-7.0.0
 >=dev-libs/libpcre-8.40
"
DEPEND="${RDEPEND}"


src_prepare() {
	sed -i -e 's/register unsigned int len/register size_t len/g'  src/parser.c src/languages.h	
}

src_compile() {
	./build ohcount || die './build failed'
}

src_install() {
	dobin bin/ohcount || die 'dobin failed'
}

