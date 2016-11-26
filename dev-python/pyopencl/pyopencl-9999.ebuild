# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 git-2

EGIT_REPO_URI="git://github.com/pyopencl/pyopencl"

DESCRIPTION="Python wrapper for OpenCL"
HOMEPAGE="http://mathema.tician.de/software/pyopencl https://pypi.python.org/pypi/pyopencl"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="examples opengl"

RDEPEND="
 >=dev-libs/boost-1.48[python,${PYTHON_USEDEP}]
 dev-python/decorator[${PYTHON_USEDEP}]
 dev-python/numpy[${PYTHON_USEDEP}]
 dev-python/mako[${PYTHON_USEDEP}]
 >=dev-python/pytools-9999[${PYTHON_USEDEP}]
 >=virtual/opencl-0-r1
"
DEPEND="${RDEPEND}"

src_prepare() {
	rm .gitmodules
	rm -rf pyopencl/compyte
}

src_configure() {
	local myconf=()
	if use opengl; then
		myconf+=(--cl-enable-gl)
	fi

	cfg() {
	"${PYTHON}" configure.py \
		--boost-compiler=gcc \
		--boost-python-libname=boost_python-${PYTHON_ABI}-mt \
		--no-use-shipped-boost \
		"${myconf[@]}"
	}
	#python_foreach_impl cfg
}

python_install_all() {
	if use examples; then
		local EXAMPLES=( examples/. )
		einfo "Some of the examples provided by this package require dev-python/matplotlib."
	fi
	distutils-r1_python_install_all
}