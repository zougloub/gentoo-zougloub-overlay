inherit eutils perl-module subversion

DESCRIPTION=""
HOMEPAGE="http://nxt.ivorycity.com/"
ESVN_REPO_URI="svn://ivorycity.com/nxt"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="usb bluetooth"
EAPI=2

RDEPEND="
 usb? ( dev-perl/Device-USB )
 bluetooth? ( dev-perl/Device-BlueTooth )
 dev-libs/libusb
 dev-lang/perl
"

DEPEND="
 $RDEPEND
"

src_configure() {
	echo -n ""
}

src_compile() {
	perl-module_src_compile
}

src_install() {
	perl-module_src_install
}