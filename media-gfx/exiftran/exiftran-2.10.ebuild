# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3

DESCRIPTION="Like jpegtran plus in-depth handling of EXIF data"
HOMEPAGE="http://www.kraxel.org/blog/linux/fbida/"
SRC_URI=""
EGIT_REPO_URI="git://git.kraxel.org/fbida"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	make exiftran
}

src_install() {
	dobin exiftran
	cp exiftran.man exiftran.1
	doman exiftran.1
}

