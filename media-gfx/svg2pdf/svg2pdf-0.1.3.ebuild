DESCRIPTION="Cairo-based SVG to PDF converter"
HOMEPAGE="http://cairographics.org/"
SRC_URI="http://cairographics.org/snapshots/${P}.tar.gz"

LICENSE="usc-isi"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
EAPI=0

DEPEND=">=x11-libs/libsvg-cairo-0.1.6"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "einstall failed"
}
