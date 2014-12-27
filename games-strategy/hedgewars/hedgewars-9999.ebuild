# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.20.5.ebuild,v 1.2 2014/11/04 22:04:26 mr_bones_ Exp $

# TODO: when physfs-2.1.0 hits the tree, set
# -DPHYSFS_SYSTEM=ON

EAPI=5
CMAKE_BUILD_TYPE=Release

inherit cmake-utils eutils games mercurial

MY_P=${PN}-src-${PV}
DESCRIPTION="A turn-based strategy, artillery, action and comedy game"
HOMEPAGE="http://hedgewars.org/"
SRC_URI=""

EHG_REPO_URI="https://code.google.com/p/hedgewars"

LICENSE="GPL-2 Apache-2.0 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+server"
QA_FLAGS_IGNORED=${GAMES_BINDIR}/hwengine # pascal sucks
QA_PRESTRIPPED=${GAMES_BINDIR}/hwengine # pascal sucks

RDEPEND="
 dev-lang/lua
 dev-qt/qtcore:4
 dev-qt/qtgui:4
 media-libs/freeglut
 media-libs/libpng:0
 media-libs/libsdl[sound,opengl,video]
 media-libs/sdl-image[png]
 media-libs/sdl-mixer[vorbis]
 media-libs/sdl-net
 media-libs/sdl-ttf
 sys-libs/zlib
 virtual/ffmpeg
 server? (
  dev-haskell/hslogger
  dev-haskell/dataenc
  dev-haskell/sha
  dev-haskell/entropy
  dev-haskell/bytestring-show
 )
"
DEPEND="${RDEPEND}
 >=dev-lang/fpc-2.4
"
RDEPEND="
 ${RDEPEND}
 media-fonts/wqy-zenhei
 >=media-fonts/dejavu-2.28
"

src_configure() {
	local mycmakeargs=(
		-DMINIMAL_FLAGS=ON
		-DCMAKE_INSTALL_PREFIX="${GAMES_PREFIX}"
		-DDATA_INSTALL_DIR="${GAMES_DATADIR}/${PN}"
		-Dtarget_binary_install_dir="${GAMES_BINDIR}"
		-Dtarget_library_install_dir="$(games_get_libdir)"
		-DCMAKE_VERBOSE_MAKEFILE=TRUE
		-DPHYSFS_SYSTEM=OFF
	)
	if use server; then
		mycmakeargs+=(
		 -DNOSERVER=FALSE
		)
	else
		mycmakeargs+=(
		 -DNOSERVER=TRUE
		)
	fi
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	DOCS="ChangeLog.txt README" cmake-utils_src_install
	rm -f "${D}"/usr/share/games/hedgewars/Data/Fonts/{DejaVuSans-Bold.ttf,wqy-zenhei.ttc}
	dosym /usr/share/fonts/dejavu/DejaVuSans-Bold.ttf \
		"${GAMES_DATADIR}"/hedgewars/Data/Fonts/DejaVuSans-Bold.ttf
	dosym /usr/share/fonts/wqy-zenhei/wqy-zenhei.ttc \
		"${GAMES_DATADIR}"/hedgewars/Data/Fonts/wqy-zenhei.ttc
	doicon misc/hedgewars.png
	make_desktop_entry ${PN} Hedgewars
	doman man/${PN}.6
	prepgamesdirs
}
