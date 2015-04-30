EAPI=5
DESCRIPTION="BlackMagic Design Driver"
HOMEPAGE="https://www.blackmagicdesign.com/support/family/capture-and-playback"
SRC_URI="http://sw.blackmagicdesign.com/DesktopVideo/v10.4/Blackmagic_Desktop_Video_Linux_10.4.tar.gz"
LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="fetch"

DEPEND="
"
RDEPEND="
 ${DEPEND}
 dev-qt/qtcore:4 dev-qt/qtgui:4
"

S="${WORKDIR}/Blackmagic_Desktop_Video_Linux_${PV}"

src_unpack() {
	default_src_unpack
	pushd "$S/other/x86_64"
	tar xf desktopvideo-10.4a17-x86_64.tar.gz
	tar xf mediaexpress-3.4a9-x86_64.tar.gz
	popd
}

src_prepare() {
	pushd "${S}/other/x86_64/desktopvideo-10.4a17-x86_64"
	epatch "${FILESDIR}/blackmagic-drivers-vs-linux.patch"
	popd
}

src_configure() {
	:
}

src_compile() {
	pushd "${S}/other/x86_64/desktopvideo-10.4a17-x86_64"
	pushd usr/src/blackmagic-10.4a17
	make -C /var/linux M="$PWD"
	popd
	pushd usr/src/blackmagic-io-10.4a17
	make -C /var/linux M="$PWD"
	popd
}

src_install() {
	pushd "${S}/other/x86_64/desktopvideo-10.4a17-x86_64"
	rm -rf usr/src
	mv * ${D}/
	popd
	pushd "${S}/other/x86_64/mediaexpress-3.4a9-x86_64"
	mv * ${D}/
	popd
}

