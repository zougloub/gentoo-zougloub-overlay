inherit eutils perl-module

DESCRIPTION=""
HOMEPAGE="http://nxt.ivorycity.com/"
MY_PV=2.00-1
SRC_URI="mirror://cpan/authors/id/C/CO/COLLINS/${PN}-${MY_PV}.tar.gz"
#ESVN_REPO_URI="svn://ivorycity.com/nxt"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="usb bluetooth"
RDEPEND="
 usb? ( dev-perl/Device-USB )
 bluetooth? ( dev-perl/Device-BlueTooth )
 dev-libs/libusb
 dev-lang/perl
"
DEPEND="
 $RDEPEND
"

S="$WORKDIR/${PN}-${MY_PV}"
