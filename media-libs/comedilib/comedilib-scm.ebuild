# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="2"

inherit eutils cvs

DESCRIPTION="Comedi DAQ library"
HOMEPAGE="http://www.comedi.org"
SRC_URI=""

ECVS_SERVER="cvs.comedi.org:/cvs/comedi"
ECVS_MODULE="comedilib"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="-ruby +python"

DEPEND="
 python? ( dev-lang/python dev-lang/swig )
 ruby? ( dev-lang/ruby dev-lang/swig )
 doc? ( app-text/docbook2X )
"
RDEPEND="${DEPEND}"

S=$WORKDIR/comedilib

src_prepare() {
	./autogen.sh
	ewarn "As of 2009-08-04, comedilib fails building with Ruby bindings"
}

src_configure() {
	econf \
	 $(use_enable ruby ruby-binding) \
	 $(use_enable python python-binding) \
	 || die "Econf failed"
}

src_compile() {
	emake || die "Emake failed"
}

src_install() {
	einstall || die "Einstall failed"
}

