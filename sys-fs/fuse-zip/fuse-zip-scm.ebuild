# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="FUSE file system to navigate, extract, create and modify ZIP archives based on libzip"
HOMEPAGE="http://code.google.com/p/fuse-zip/"

inherit eutils mercurial

SRC_URI=""
EHG_REPO_URI="https://fuse-zip.googlecode.com/hg"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="
 dev-libs/libzip
 sys-fs/fuse
"
RDEPEND="${DEPEND}"

S="$WORKDIR/hg"

src_prepare() {
	# Fix strip than installing fuse-zip
	sed -i -e 's/install -m 755 -s/install -m 755/' Makefile || die "sed failed"
}

src_install() {
	emake INSTALLPREFIX="${D}"/usr install || die "Failed to install"
	gzip -d $D/usr/share/man/man1/fuse-zip.1.gz
	dodoc README TODO changelog
}

