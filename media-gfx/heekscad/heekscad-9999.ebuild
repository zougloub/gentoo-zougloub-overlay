

EAPI=5

inherit eutils git-r3 cmake-utils

EGIT_REPO_URI="git://github.com/Heeks/heekscad"
DESCRIPTION="CAD application based on OpenCASCADE"
HOMEPAGE="https://github.com/Heeks/heekscad"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE="+python"
RESTRICT="primaryuri"
SLOT="0"

RDEPEND="
 sci-libs/opencascade:6.9.0
 x11-libs/wxGTK
"

DEPEND="${RDEPEND}
"

src_prepare() {
	sed -i \
	 -e 's/cmdLineDesc\[0\]\.description = _T\("input files"\);/cmdLineDesc[0].description = _T("input files");/g' \
	 src/HeeksCAD.cpp
}

src_configure() {
	local mycmakeargs=(
	 -DwxWidgets_CONFIG_EXECUTABLE=/usr/bin/wx-config-3.0
	 -DwxWidgets_wxrc_EXECUTABLE=/usr/bin/wxrc-3.0
	 -DwxWidgets_USE_UNIVERSAL=ON
	)
	cmake-utils_src_configure
}
