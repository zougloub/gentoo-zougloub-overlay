# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit subversion

DESCRIPTION="OpenGL man pages"
HOMEPAGE="http://www.opengl.org/wiki/Getting_started/XML_Toolchain_and_Man_Pages"
SRC_URI=""

ESVN_USER="anonymous"
ESVN_PASSWORD="anonymous"
ESVN_PROJECT="opengl-manpages"
ESVN_RESTRICT="export"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 >=app-text/dbmathml-1.0
 >=dev-libs/libxlst-1.0.0
"
RDEPEND="${DEPEND}"

S="$WORKDIR"

src_unpack() {
	for repo in man4 man3 man2 manglsl;
	do
		local ESVN_REPO_URI=https://cvs.khronos.org/svn/repos/ogl/trunk/ecosystem/public/sdk/docs/$repo/
		subversion_fetch || die "Failed to fetch $repo"
	done
}

src_configure() {
	:
}

src_compile() {
	for repo in man4 man3 man2 manglsl;
	do
		mkdir $repo
		pushd $repo
		for file in ${ESVN_STORE_DIR}/${ESVN_PROJECT}/$repo/gl*.xml;
		do
			xsltproc --noout --nonet ${ROOT}/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl $file
		done
		popd
	done
}

src_install() {
	doman -r man4 man3 man2 manglsl
}

