# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )
DISTUTILS_OPTIONAL=1
inherit cmake-utils eutils distutils-r1 git-r3

DESCRIPTION="Flexible and Efficient Library for Deep Learning"
HOMEPAGE="http://mxnet.io/"
EGIT_REPO_URI="https://github.com/dmlc/mxnet"
EGIT_SUBMODULES=( "*" "-dmlc-core" "-nnvm" "-ps-lite" )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cuda cudnn distributed examples jemalloc lapack opencv openmp python tcmalloc"

RDEPEND="sci-libs/dmlc-core
	sci-libs/nnvm
	sci-libs/atlas
	cuda? ( dev-util/nvidia-cuda-toolkit
		cudnn? ( dev-libs/cudnn )
	)
	distributed? ( sci-libs/ps-lite )
	jemalloc? ( dev-libs/jemalloc )
	lapack? ( virtual/lapack )
	opencv? ( media-libs/opencv )
	python? ( ${PYTHON_DEPS} dev-python/numpy[${PYTHON_USEDEP}] )
	tcmalloc? ( dev-util/google-perftools )
"
# sci-libs/openblas

DEPEND="${RDEPEND}
	python? ( dev-python/setuptools[${PYTHON_USEDEP}] )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )
	?? ( tcmalloc jemalloc )"

PATCHES=( "${FILESDIR}/${P}-python-fix-library-load-and-install.patch" )

pkg_setup() {
	lsmod|grep -q '^nvidia_uvm'
	if [ $? -ne 0 ] || [ ! -c /dev/nvidia-uvm ]; then
		eerror "Please run: \"nvidia-modprobe -u -c 0\" before attempting to install ${PN}."
		eerror "Otherwise the hardware autodetect will fail and all architecture modules will be built."
	fi
}

src_prepare() {
	cmake-utils_src_prepare
	if use python; then
		cd "${S}"/python
		distutils-r1_src_prepare
	fi
	if use distributed; then
		cd "${S}"
		epatch "${FILESDIR}/${P}-Use-zmq-shared-library.patch"
		epatch "${FILESDIR}/${P}-Use-shared-pslite.patch"
	fi
	cd "${S}"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DUSE_CUDA=$(usex cuda)
		-DUSE_MKL_IF_AVAILABLE=OFF
		-DUSE_OLDCMAKECUDA=1
		-DUSE_CUDNN=$(usex cudnn)
		-DUSE_GPERFTOOLS=$(usex tcmalloc)
		-DUSE_JEMALLOC=$(usex jemalloc)
		-DUSE_LAPACK=$(usex lapack)
		-DUSE_OPENCV=$(usex opencv)
		-DUSE_OPENMP=$(usex openmp)
		-DUSE_BLAS:STRING=Atlas
		-DBLAS:STRING=Atlas
		-DUSE_DIST_KVSTORE=$(usex distributed)
		-DINSTALL_EXAMPLES=$(usex examples)
	)

	addwrite /dev/nvidia-uvm
	addwrite /dev/nvidiactl
	addwrite /dev/nvidia0

	cmake-utils_src_configure

	if use python; then
		cd python;
		distutils-r1_src_configure
	fi
}

src_compile() {
	cmake-utils_src_compile

	if use python; then
		cd python
		export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:${BUILD_DIR}"
		distutils-r1_src_compile
	fi
}

src_install() {
	doheader -r include/mxnet

	if use python; then
		cd python
		distutils-r1_src_install
	fi

	cd "${BUILD_DIR}"
	dolib.so libmxnet.so
}
