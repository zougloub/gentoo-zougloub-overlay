EAPI=5
PYTHON_COMPAT=( python{2_{6,7},3_{2,3}} pypy2_0 )

inherit distutils-r1 git-r3 waf-utils

DESCRIPTION="Character encoding auto-detection library"

HOMEPAGE="https://github.com/zougloub/libchardet"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zougloub/libchardet.git"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE="+python"

WAF_BINARY=../waf/waf-light

src_unpack() {
	git-r3_src_unpack
	EGIT_REPO_URI="https://code.google.com/p/waf"
	git-r3_src_unpack
	git-r3_checkout $EGIT_REPO_URI "$WORKDIR/waf"
}

src_configure() {
	waf-utils_src_configure
}

src_compile() {
	waf-utils_src_compile
	use python && cd python && distutils-r1_src_compile
}

src_install() {
	waf-utils_src_install
	use python && cd python && distutils-r1_src_install
}

python_compile() {
	 distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install
}

python_install_all() {
	distutils-r1_python_install_all
}

