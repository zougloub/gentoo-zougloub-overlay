# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="The Docbook MathML Module V1.1b1 DTD adds MathML 2.0 to Docbook 4.3"
HOMEPAGE=""
SRC_URI="http://www.docbook.org/xml/mathml/1.1CR1/dbmathml.dtd -> dbmathml-1.1CR1.dtd"
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
	cp ${DISTDIR}/dbmathml-1.1CR1.dtd ${S}/dbmathml.dtd || die
}

src_install() {
	insinto /usr/share/xml/docbook-mathml-dtd-1.1CR1
	doins dbmathml.dtd
}

pkg_postinst() {
	ebegin "Installing XML catalog entries for dbmathml"
	xmlcatalog --noout --add public \
	 "-//OASIS//DTD DocBook MathML Module V1.1b1//EN" \
	 "file:///usr/share/xml/docbook-mathml-dtd-1.1CR1/dbmathml.dtd" \
	 /etc/xml/catalog || die
	xmlcatalog --noout --add system \
	 "http://www.oasis-open.org/docbook/xml/mathml/1.1CR1/dbmathml.dtd" \
	 "file:///usr/share/xml/docbook-mathml-dtd-1.1CR1/dbmathml.dtd" \
	 /etc/xml/catalog || die
	eend 0
}

