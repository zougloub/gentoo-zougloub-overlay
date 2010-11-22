# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit python eutils distutils subversion

EAPI="3"
PYTHON_DEPEND="*::3.1"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.[2-9]"

DESCRIPTION="A Pythonic binding for the libxml2 and libxslt libraries"
HOMEPAGE="http://codespeak.net/lxml/ http://pypi.python.org/pypi/lxml"
SRC_URI=""
ESVN_REPO_URI="http://codespeak.net/svn/lxml/trunk"
LICENSE="BSD ElementTree GPL-2 PSF-2.4"
SLOT="0"
IUSE="doc examples +threads"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x64-solaris ~x86-solaris"

RDEPEND="
 >=dev-libs/libxml2-2.7
 >=dev-libs/libxslt-1.1
 >=dev-python/beautifulsoup-3.0.8
"
DEPEND="
 dev-python/setuptools
 $RDEPEND
"
# lxml tarball contains files pregenerated by Cython.

PYTHON_CFLAGS=("2.* + -fno-strict-aliasing")

# Compiler warnings are suppressed without --warnings option.
DISTUTILS_GLOBAL_OPTIONS=("--warnings")

src_prepare() {
	distutils_src_prepare
}

src_compile() {
	distutils_src_compile $(use threads || echo --without-threading)
}

src_test() {
	testing() {
		# Tests are broken with Python 3.
		[[ "${PYTHON_ABI}" == 3.* ]] && return

		local module
		for module in lxml/etree lxml/objectify; do
			ln -fs "../../$(ls -d build-${PYTHON_ABI}/lib.*)/${module}.so" "src/${module}.so" || die "ln -fs src/${module} failed"
		done

		local return_status="0" test
		for test in test.py selftest.py selftest2.py; do
			einfo "Running ${test}"
			if ! PYTHONPATH="$(ls -d build-${PYTHON_ABI}/lib.*)" "$(PYTHON)" "${test}"; then
				eerror "${test} failed with $(python_get_implementation) $(python_get_version)"
				return_status="1"
			fi
		done

		return "${return_status}"
	}
	python_execute_function testing
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/*
		dodoc *.txt
		docinto doc
		dodoc doc/*.txt
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r samples/*
	fi
}

