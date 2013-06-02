# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils

DESCRIPTION="Moose Distributed File System"
HOMEPAGE="http://www.moosefs.org/"
SRC_URI="http://moosefs.org/tl_files/mfscode/mfs-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="+masterserver +chunkserver +client -cgi -cgiserver"

RDEPEND="
 sys-fs/fuse
"
DEPEND="
 ${RDEPEND}
"
RESTRICT="mirror primaryuri"

S="${WORKDIR}/mfs-${PV}"

src_configure() {
	econf \
	 $(use_enable masterserver mfsmaster) \
	 $(use_enable chunkserver mfschunkserver) \
	 $(use_enable client mfsmount) \
	 $(use_enable cgi mfscgi) \
	 $(use_enable cgiserver mfscgiserver)
}

src_install () {
	emake DATA_DIR="${D}/var/lib" DESTDIR="${D}" install
	dodoc NEWS README UPGRADE
}

pkg_postinst() {
	einfo "The package documentation will introduce you to MooseFS usage."
	einfo " run: man moosefs"
	ewarn "If you upgrade the software, read the UPGRADE file" \
	 " provided in the documentation folder"
}

