# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="Arimo, Tinos and Cousine in 4 weights developed by Ascender for Chrom*OS"
SRC_URI="http://commondatastorage.googleapis.com/chromeos-localmirror/distfiles/${P}.tar.gz"

LICENSE="OFL-1.1"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${S}"
FONTDIR="/usr/share/fonts/croscore"


# Only installs fonts
RESTRICT="strip binchecks"

src_install() {
        # call src_install() in font.eclass.
	font_src_install
}
