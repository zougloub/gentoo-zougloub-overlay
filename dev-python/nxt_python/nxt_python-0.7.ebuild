inherit distutils

DESCRIPTION="NXT_Python is a package for controlling a LEGO NXT robot using the Python programming language"
HOMEPAGE="http://home.comcast.net/~dplau/nxt_python/index.html"
SRC_URI="http://home.comcast.net/~dplau/nxt_python/download/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="bluetooth"
RDEPEND="
 dev-python/pyusb
"
DEPEND="
 $RDEPEND
"
