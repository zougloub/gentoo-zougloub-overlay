# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_{3,4,5}} pypy2_0 )

inherit cmake-utils git-r3 multilib python-r1


DESCRIPTION="Core library for accessing the Microsoft Kinect."
HOMEPAGE="https://github.com/OpenKinect/libfreenect"
EGIT_REPO_URI="git://github.com/OpenKinect/${PN}.git"

LICENSE="Apache-2.0 GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="audio bindist +c_sync +cpp doc examples fakenect opencv openni2 python"

COMMON_DEP="
 virtual/libusb:1
 examples? (
   media-libs/freeglut
   virtual/opengl
   x11-libs/libXi
   x11-libs/libXmu
 )
 opencv? ( media-libs/opencv )
 python? ( dev-python/numpy )
 openni2? ( dev-libs/OpenNI2 )
"

RDEPEND="
 ${COMMON_DEP}
"
DEPEND="
 ${COMMON_DEP}
 dev-util/cmake
 virtual/pkgconfig
 audio? ( || ( dev-lang/python:2.7 dev-lang/python:3.2 dev-lang/python:3.3 ) )
 doc? ( app-doc/doxygen )
 python? ( dev-python/cython )
"

src_pretend() {
	if use audio; then
		einfo "USE audio will require internet access during compilation, to get a binary"
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_build audio    AUDIO)
		$(cmake-utils_use_build bindist  REDIST_PACKAGE)
		$(cmake-utils_use_build c_sync   C_SYNC)
		$(cmake-utils_use_build cpp      CPP)
		$(cmake-utils_use_build examples EXAMPLES)
		$(cmake-utils_use_build fakenect FAKENECT)
		$(cmake-utils_use_build opencv   CV)
		$(cmake-utils_use_build openni2  OPENNI2_DRIVER)
	)

	cfg() {
		echo $EPYTHON
		if [ "x${EPYTHON//python3/}" != "x${EPYTHON}" ]; then
			mycmakeargs+=(
			 $(cmake-utils_use_build python   PYTHON3)
			)
		fi
		if [ "x${EPYTHON//python2/}" != "x${EPYTHON}" ]; then
			mycmakeargs+=(
			 $(cmake-utils_use_build python   PYTHON2)
			)
		fi
	}

	python_foreach_impl cfg

	unset -f PYTHON

	# work around cmake-3.1.0-FindPythonInterp.patch
	export CMAKE_BUILD_TYPE=RelWithDebInfo

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	insinto /lib/udev/rules.d/
	doins "${S}"/platform/linux/udev/51-kinect.rules

	mkdir -p "${D}/usr/lib/OpenNI2"
	mv "${D}/usr/lib/OpenNI2-FreenectDriver" "${D}/usr/lib/OpenNI2/Drivers"

	dodoc README.md
	if use doc; then
		cd doc
		doxygen || ewarn "doxygen failed"
		dodoc -r html || ewarn "dodoc failed"
		cd -
	fi
}

pkg_postinst() {
	if ! use bindist; then
		ewarn "The bindist USE flag is disabled. Resulting binaries may not be legal to re-distribute."
	fi
	elog "Make sure your user is in the 'video' group"
	elog "Just run 'gpasswd -a <USER> video', then have <USER> re-login."
}

