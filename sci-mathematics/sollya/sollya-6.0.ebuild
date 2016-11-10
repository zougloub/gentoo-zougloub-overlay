# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools

DESCRIPTION="Sollya is both a tool environment and a library for safe floating-point code development."
HOMEPAGE="http://sollya.gforge.inria.fr/"
SRC_URI="https://gforge.inria.fr/frs/download.php/file/36271/${P}.tar.bz2"

LICENSE="CeCILL-C"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
 sci-libs/mpfi
 sci-libs/fplll
"
RDEPEND="${DEPEND}"
