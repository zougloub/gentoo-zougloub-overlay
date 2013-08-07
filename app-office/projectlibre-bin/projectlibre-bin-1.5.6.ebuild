# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit java-pkg-2

DESCRIPTION="A desktop replacement for Microsoft Project."
HOMEPAGE="http://www.projectlibre.org"
SRC_URI="mirror://sourceforge/projectlibre/projectlibre-${PV}.tar.gz"

LICENSE="CPAL-1.0"

SLOT="0"
IUSE=""

KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.6"
RDEPEND=">=virtual/jdk-1.6"

S="$WORKDIR/projectlibre-${PV}"

src_prepare() {
	sed -i -e 's@^OPENPROJ_HOME=.*$@OPENPROJ_HOME=/usr/share/projectlibre-bin@' "$S/projectlibre.sh"
}

src_compile() {
	:
}

src_install() {
	java-pkg_jarinto "/usr/share/${PN}/lib/"
	java-pkg_dojar ${S}/lib/*.jar

	java-pkg_jarinto "/usr/share/${PN}/"
	java-pkg_dojar ${S}/*.jar

	insinto "/usr/share/${PN}/"
	doins ${S}/projectlibre.sh
	fperms a+rx "/usr/share/${PN}/projectlibre.sh"

	echo -ne '#!/bin/bash\n/usr/share/projectlibre-bin/projectlibre.sh "$@"\n' > projectlibre
	dobin projectlibre
}

