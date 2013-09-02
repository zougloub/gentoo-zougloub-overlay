# Copyright (c) 2010 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit font

DESCRIPTION="Free fonts from the exljbris Font Foundry"
HOMEPAGE="http://www.exljbris.com/"
SRC_URI="
 http://www.exljbris.com/dl/delicious-123.zip
 http://www.exljbris.com/dl/Diavlo_II_37b2.zip
 http://www.exljbris.com/dl/fontin_pc.zip
 http://www.exljbris.com/dl/FontinSans_49.zip
 http://www.exljbris.com/dl/FontinSans_Cyrillic_46b.zip
 http://www.exljbris.com/dl/tallys_15b2.zip
"

LICENSE="http://www.exljbris.com/eula.html"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh x86 ~x86-fbsd"
IUSE=""

FONT_SUFFIX="otf ttf"
FONT_S="${S}"
FONTDIR="/usr/share/fonts/exljbris"


# Only installs fonts
RESTRICT="strip binchecks primaryuri"

src_install() {
        # call src_install() in font.eclass.
	font_src_install
}
