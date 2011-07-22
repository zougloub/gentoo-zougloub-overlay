# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit distutils

DESCRIPTION="Lets you see your Python program's execution as a tree of function
invocations, each tree node exposing the real time, and CPU time (user/sys) of
that call."

HOMEPAGE="https://pythontracer.googlecode.com"
SRC_URI="https://pythontracer.googlecode.com/files/pythontracer-8.10.16-source.tar.gz"
LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RDEPEND="
"

DEPEND="
 $RDEPEND
"

SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

