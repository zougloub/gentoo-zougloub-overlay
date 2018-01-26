EAPI=5

EGIT_REPO_URI="git://github.com/exmakhina/DeepCL.git"
EGIT_BRANCH="unbundle"

PYTHON_COMPAT=( python{2_7,3_{4,5,6}} )

inherit toolchain-funcs multilib cmake-utils git-r3 python-r1 python-utils-r1

DESCRIPTION="Deep learning framework"
HOMEPAGE="https://github.com/hughperkins/DeepCL"
SRC_URI=""

LICENSE="MPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+python"

CDEPEND="
 dev-libs/easycl
 python? (
  ${PYTHON_DEPS}
 )
"
DEPEND="
 ${CDEPEND}
"
RDEPEND="
 ${CDEPEND}
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_configure() {
	local mycmakeargs=(
	 -DMAINTAINER_OPTIONS:BOOL="1"
	 -DPROTOTYPING:BOOL="1"
	 -DCMAKE_BUILD_TYPE:STRING="Release"
	 -DUSE_CLEW:BOOL="0"
	)
	if use python; then
		mycmakeargs+=(
		 -DBUILD_PYTHON_WRAPPERS:BOOL="1"
		 -DDEV_RUN_CYTHON:BOOL="1"
		)
	fi

	tc-export CC CXX

	if use python; then
		configuration() {
			local mycmakeargs=(
				-DPYTHON_SUFFIX="-${EPYTHON}"
				"${mycmakeargs[@]}"
			)
			cmake-utils_src_configure
		}
		python_foreach_impl configuration
	else
		cmake-utils_src_configure
	fi
}

src_compile() {
	python_foreach_impl cmake-utils_src_make
}

src_install() {
	installation() {
		cmake-utils_src_install
		python_get_sitedir
		mkdir -p ${D}/${PYTHON_SITEDIR}
		mv ${D}/usr/lib/PyDeepCL.so ${D}/${PYTHON_SITEDIR}/
	}
	if use python; then
		python_foreach_impl installation
	else
		cmake-utils_src_install
	fi
	rm -r ${D}/usr/bin/activate.bat
	rm -r ${D}/usr/bin/activate.sh
}

