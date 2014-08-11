# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit multilib

DESCRIPTION="Alternative to vendor specific OpenCL ICD loaders"
HOMEPAGE="http://www.khronos.org/registry/cl/"
SRC_URI="http://www.khronos.org/registry/cl/specs/${P}.tgz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND="
 dev-util/opencl-headers
"
RDEPEND="app-admin/eselect-opencl"

S="${WORKDIR}/icd"

src_install() {
	dolib bin/lib*
	dobin bin/icd_loader_test
}
