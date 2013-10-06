# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="MathML2 Module DTD"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 >=dev-libs/libxml2-2.8.0
"
RDEPEND="${DEPEND}"

RESTRICT=primaryuri
SRC_URI="http://www.w3.org/Math/DTD/mathml2.tgz -> ${P}.tgz"
S="$WORKDIR/mathml2"

src_install() {
	insinto /usr/share/xml/mathml2-dtd
	doins -r *
	return
	for file in $files;
	do
		doins $file
	done
}

pkg_postinst() {
	ebegin "Installing XML catalog entries"
	xmlcatalog --noout --add public \
	 "-//W3C//ENTITIES MathML 2.0 Qualified Names 1.0//EN" \
	 "file:///usr/share/xml/mathml2-dtd/mathml2-qname-1.mod" \
	 /etc/xml/catalog || die
	eend 0
}

