NEED_PYTHON=2.4

inherit distutils

KEYWORDS="~amd64 ~x86"
DESCRIPTION="UniConvertor is a command line tool for conversion of vector graphics between popular formats."
HOMEPAGE="http://sk1project.org/modules.php?name=Products&product=uniconvertor"
SRC_URI="http://sk1project.org/downloads/${PN}/v${PV}/${P}.tar.gz"
LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
IUSE=""

RDEPEND="dev-python/imaging"

MY_PN="UniConvertor"
S=${WORKDIR}/${MY_PN}-${PV}

src_install() {
	distutils_src_install
	# uniconv name already used for a text re-encoder...
	mv "${D}/usr/bin/uniconv" "${D}/usr/bin/uniconvertor"
}
