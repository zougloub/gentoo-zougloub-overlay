inherit distutils

DESCRIPTION="PyUSB provides USB access on the Python language"
HOMEPAGE="http://sourceforge.net/projects/pyusb/"
SRC_URI="mirror://sourceforge/pyusb/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
RDEPEND="
 dev-libs/libusb
"
DEPEND="
 $RDEPEND
"
