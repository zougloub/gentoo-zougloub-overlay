# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://jsoncpp.svn.sourceforge.net/svnroot/jsoncpp/trunk/jsoncpp"
inherit eutils toolchain-funcs subversion

DESCRIPTION="C++ library to read and write JSON"
HOMEPAGE="http://jsoncpp.sourceforge.net/"
SRC_URI=""

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE="debug doc"

DEPEND="
 doc? ( app-doc/doxygen )
"

RDEPEND="
"

src_configure() {
	:
}

src_compile() {
	einfo "The jsoncpp build system is old, we build manually..."
	CXX="$(tc-getCXX)"
	for file in src/lib_json/*.cpp;
	do
		ebegin "[CXX] $file"
		$CXX -fPIC -o "${file/cpp/o}" -c "${file}" -I include
		eend $?
	done
	ebegin "[LIB] jsoncpp"
	$CXX -shared -o libjsoncpp.so src/lib_json/*.o
	eend $?
}

src_install () {
	dolib libjsoncpp.so
	insinto /usr/
	doins -r include
}

