# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools eutils git-2

DESCRIPTION="Hardware access and backend lib"
HOMEPAGE="http://sigrok.org"
SRC_URI=""

EGIT_REPO_URI="git://sigrok.org/libsigrok"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

IUSE_SIGROK_DRIVERS=(
 agilent-dmm
 alsa
 asix-sigma
 brymen-dmm
 chronovu-la8
 colead-slm
 demo
 fluke-dmm
 fx2lafw
 hantek-dso
 lascar-el-usb
 link-mso19
 mic-985xx
 nexus-osciprime
 ols
 rigol-ds1xx2
 serial-dmm
 tondaj-sl-814
 uni-t-dmm
 victor-dmm
 zeroplus-logic-cube
)

DEPEND="
 dev-libs/libusb:1
"

RDEPEND="$DEPEND"

NUM_DRIVERS=${#IUSE_SIGROK_DRIVERS[@]}
index=0
while [ "${index}" -lt "${NUM_DRIVERS}" ] ; do
        IUSE="${IUSE} sigrok_drivers_${IUSE_SIGROK_DRIVERS[${index}]}"
        let "index = ${index} + 1"
done


RESTRICT="primaryuri"

src_prepare() {
	eautoreconf
}

src_configure() {
	local args=""
	local index=0
	while [ "${index}" -lt "${NUM_DRIVERS}" ] ; do
		args+=" $(use_enable sigrok_drivers_${IUSE_SIGROK_DRIVERS[${index}]} ${IUSE_SIGROK_DRIVERS[${index}]})"
        let "index = ${index} + 1"
	done

	econf $args
}

src_compile() {
	default_src_compile
}

