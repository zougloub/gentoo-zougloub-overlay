# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

EGIT_REPO_URI="git://developer.intra2net.com/${PN}"
inherit git-2 cmake-utils
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"

DESCRIPTION="Userspace access to FTDI USB interface chips"
HOMEPAGE="http://www.intra2net.com/en/developer/libftdi/"

LICENSE="LGPL-2"
SLOT="0"
IUSE="cxx doc examples python static-libs"

RDEPEND="
 virtual/libusb:1
 cxx? ( dev-libs/boost )
 python? ( dev-lang/python )
"

DEPEND="
 ${RDEPEND}
 doc? ( app-doc/doxygen )
"

src_unpack() {
	git-2_src_unpack
}

src_configure2() {
	econf \
		--with-async-mode \
		$(use_enable cxx libftdipp) \
		$(use_with doc docs) \
		$(use_with examples) \
		$(use_enable python python-binding) \
		$(use_enable static-libs static)
}

src_install() {
	cmake-utils_src_install

	#emake DESTDIR="${D}" install || die
	use static-libs || find "${D}" -name '*.la' -delete
	dodoc ChangeLog README

	if use doc ; then
		doman doc/man/man3/*
		dohtml doc/html/*
	fi
	if use examples ; then
		docinto examples
		dodoc examples/*.c
	fi
}

