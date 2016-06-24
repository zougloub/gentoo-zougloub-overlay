EAPI=5

inherit autotools eutils git-r3

DESCRIPTION="WebRTC Gateway"
HOMEPAGE="https://janus.conf.meetecho.com/"
SRC_URI=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
EGIT_REPO_URI="https://github.com/meetecho/janus-gateway.git"

IUSE="-data-channels +rest +websockets +rabbitmq -docs"

RDEPEND="
 data-channels? ( net-libs/libusrsctp )
 rest? ( net-libs/libmicrohttpd )
 websockets? ( net-libs/libwebsockets )
 rabbitmq? ( net-libs/rabbitmq-c )
"
DEPEND="
 dev-util/gengetopt
"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
	 $(use_enable data-channels) \
	 $(use_enable rest) \
	 $(use_enable websockets) \
	 $(use_enable rabbitmq) \
	 $(use_enable docs)
}

