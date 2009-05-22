# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Encoder/decoder for mo3 sound file format"
HOMEPAGE="http://www.un4seen.com/mo3.html"
LICENSE="Proprietary"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""
SRC_URI="http://us2.un4seen.com/files/mo324-linux.zip"
RDEPEND=""
DEPEND="${RDEPEND}"

EAPI=2

src_install() {
	for file in mo3enc unmo3;
		chmod +x $file
		dobin $file
	done
	dodoc mo3.txt
}
