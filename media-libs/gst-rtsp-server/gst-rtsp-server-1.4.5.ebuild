# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_DEPEND="2"
inherit python git-r3 autotools

DESCRIPTION="A GStreamer based RTSP server"
HOMEPAGE="http://people.freedesktop.org/~wtay/"
SRC_URI="" #http://people.freedesktop.org/~wtay/${P/-server/}.tar.bz2"

EGIT_REPO_URI="git://anongit.freedesktop.org/gstreamer/gst-rtsp-server"
EGIT_COMMIT="1.4.5"

LICENSE="GPL-2"
SLOT="1.0"
KEYWORDS="amd64 x86"
IUSE="debug doc +introspection nls static-libs vala"
#S="${WORKDIR}/${P/-server/}"

# ./configure is broken, so PYGOBJECT_REQ must be defined
PYGOBJECT_REQ=2.11.2

RDEPEND="
	>=dev-libs/glib-2.10.0:2
	dev-libs/libxml2
	>=dev-python/pygobject-${PYGOBJECT_REQ}:2
	dev-python/gst-python:1.0
	introspection? ( >=dev-libs/gobject-introspection-0.6.3 )
	>=media-libs/gstreamer-1.0:1.0[introspection?]
	>=media-libs/gst-plugins-base-1.0:1.0[introspection?]
	vala? ( dev-lang/vala )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.3 )
	nls? ( >=sys-devel/gettext-0.17 )"

pkg_setup() {
	python_set_active_version 2
}

src_prepare() {
	#sed -i -e 's/1.5.0.1/1.4.5/g' configure.ac
	eautoreconf
}

src_configure() {
	econf \
		--with-package-origin="http://www.gentoo.org" \
		$(use_enable debug) \
		$(use_enable doc gtk-doc) \
		$(use_enable nls) \
		$(use_enable introspection) \
		$(use_enable static-libs static) \
		$(use_enable vala) \
		PYGOBJECT_REQ=${PYGOBJECT_REQ}
}

src_install() {
	dodoc AUTHORS TODO
	emake install DESTDIR="${D}"
}
