EAPI=5
DESCRIPTION="Library for blob detection"
HOMEPAGE="https://code.google.com/p/cvblob"
EHG_REPO_URI="https://code.google.com/p/cvblob"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT=0
IUSE="+doc +examples test"

inherit eutils mercurial cmake-utils

RDEPEND="
"

DEPEND="
 doc? ( app-doc/doxygen virtual/latex-base )
 $RDEPEND
"

src_unpack() {
	mercurial_src_unpack
}

src_prepare() {
	:
}

pkg_setup() {
	:
}

src_configure() {
	cmake-utils_src_configure
}

src_test() {
	:
}

src_install() {
	cmake-utils_src_install
}

