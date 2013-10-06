# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="MathML2 Module DTD"
HOMEPAGE=""
SRC_URI="
 http://www.w3.org/TR/MathML2/dtd/mathml2.dtd -> mathml2-xxx.dtd
"
RESTRICT="primaryuri"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 >=dev-libs/libxml2-2.8.0
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp ${DISTDIR}/mathml2-xxx.dtd ${S}/mathml2.dtd || die
}

src_install() {
	insinto /usr/share/xml/mathml2-dtd
	doins mathml2.dtd
}

pkg_postinst() {
	ebegin "Installing XML catalog entries"
	xmlcatalog --noout --add public \
	 "-//W3C//DTD MathML 2.0//EN" \
	 "file:///usr/share/xml/mathml2-dtd/mathml2.dtd" \
	 /etc/xml/catalog || die
	xmlcatalog --noout --add system \
	 "http://www.w3.org/TR/MathML2/dtd/mathml2.dtd" \
	 "file:///usr/share/xml/mathml2-dtd/mathml2.dtd" \
	 /etc/xml/catalog || die
	eend 0
}

