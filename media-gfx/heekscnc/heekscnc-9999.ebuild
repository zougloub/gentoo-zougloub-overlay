EAPI=5

inherit eutils git-r3 cmake-utils

EGIT_REPO_URI="git://github.com/Heeks/heekscnc"
DESCRIPTION="CNC plug-in for heekscad"
HOMEPAGE="https://github.com/Heeks/heekscnc"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="+python"
RESTRICT="primaryuri"
SLOT="0"

RDEPEND="
 media-gfx/heekscad
"

DEPEND="${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
	 -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config-3.0
	 -DwxWidgets_wxrc_EXECUTABLE=/usr/bin/wxrc-3.0
	 -DwxWidgets_USE_UNIVERSAL=ON
	)
	cmake-utils_src_configure
}
