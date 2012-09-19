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
	einfo "The jsoncpp build system and sources are messed up, we build manually..."
	ebegin "[PATCH] everything"
	sed -i -e 's/<json\//<jsoncpp\//' src/lib_json/*
	sed -i -e 's/<json\/config.h>/"jsoncpp\/config.h"/' include/json/*
	for x in features config forwards value autolink reader writer;
	do
		sed -i -e "s/\"${x}.h\"/\"jsoncpp\/${x}.h\"/" include/json/*
	done
	#sed -i -e 's/"value.h"/jsoncpp\/value.h/' include/json/*
	#for file in config.h features.h;
	#do
	#	mv include/json/$file include/json/jsoncpp-$file
	#done
	mv include/json include/jsoncpp
	eend $?
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

