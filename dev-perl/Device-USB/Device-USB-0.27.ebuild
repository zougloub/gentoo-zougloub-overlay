inherit eutils perl-module

DESCRIPTION=""
HOMEPAGE="http://search.cpan.org/~gwadej/Device-USB-0.27/lib/Device/USB.pm"
SRC_URI="mirror://cpan/authors/id/G/GW/GWADEJ/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""
RDEPEND="
 dev-libs/libusb
 dev-lang/perl
"
DEPEND="
 $RDEPEND
 dev-perl/Inline
 dev-perl/ExtUtils-MakeMaker
"

