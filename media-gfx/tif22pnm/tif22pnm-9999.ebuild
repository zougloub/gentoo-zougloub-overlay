# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_4 )
PYTHON_REQ_USE='threads(+)' # required by waf

inherit python-any-r1 waf-utils git-r3

DESCRIPTION="tif22pnm and png22pnm command-line converters"
HOMEPAGE="https://github.com/pts/tif22pnm"
SRC_URI=""
EGIT_REPO_URI="git://github.com/zougloub/tif22pnm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
 >=media-libs/libpng-1.2:0
 media-libs/tiff:0
"
DEPEND="
 ${PYTHON_DEPS}
 ${RDEPEND}
"

WAF_BINARY="${S}/waf/waf-light"

src_unpack() {
	git-r3_src_unpack
	EGIT_REPO_URI="https://github.com/waf-project/waf.git"
	EGIT_CHECKOUT_DIR="${S}/waf"
	git-r3_src_unpack
}

src_install() {
	waf-utils_src_install
	dodoc README
}

