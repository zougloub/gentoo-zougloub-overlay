NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"
DESCRIPTION="UniConvertor - commandline tool for popular vector formats convertion."
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://sk1project.org/downloads/${PN}/v${PV}/${P}.tar.gz"
LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
IUSE=""

RDEPEND="dev-python/imaging"

MY_PN="UniConvertor"
S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	# uniconv name already used for a text re-encoder...
	mv "${D}/usr/bin/uniconv" "${D}/usr/bin/uniconvertor"
	distutils_src_install
}
