# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/portaudio/portaudio-19_pre20110326.ebuild,v 1.1 2011/05/28 20:58:51 xarthisius Exp $

EAPI=4

inherit libtool git-2

DESCRIPTION="A free, cross-platform, open-source, audio I/O library"
HOMEPAGE="http://www.portaudio.com/"
SRC_URI=""

EGIT_REPO_URI="ssh://git@git/portaudio"
EGIT_COMMIT="master"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE="alsa +cxx debug jack oss static-libs"

RDEPEND="alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	elibtoolize
}

src_configure() {
	export CFLAGS="$CFLAGS -D PA_ALSA_USE_OBSOLETE_HOST_BUFFER_CALC"

	econf \
		$(use_enable debug debug-output) \
		$(use_enable cxx) \
		$(use_enable static-libs static) \
		$(use_with alsa) \
		$(use_with jack) \
		$(use_with oss)
}

src_compile() {
	emake lib/libportaudio.la || die
	emake || die
}

src_install() {
	default

	find "${D}" -name '*.la' -exec rm -f {} +

	dodoc README.txt
	dohtml index.html
}

