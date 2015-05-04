EAPI=5

inherit font

DESCRIPTION="Flexible system of fonts designed specifically for code by David Jonathan Ross"
HOMEPAGE="http://input.fontbureau.com"
SRC_URI="http://input.fontbureau.com/build/?accept=I+do= -> ${P}.zip"
LICENSE="http://input.fontbureau.com/download/"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh x86 ~x86-fbsd"
IUSE=""

S="${WORKDIR}/Input_Fonts"

# Only installs fonts
RESTRICT="strip binchecks primaryuri"

src_install() {
	for dir in */*; do
		FONT_SUFFIX="ttf"
		FONT_S="${dir}"
		FONTDIR="/usr/share/fonts/input"
		font_src_install
	done
}

