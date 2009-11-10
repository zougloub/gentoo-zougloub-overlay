# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit eutils

MY_P=ccx_${PV}

DESCRIPTION="A Free Software Three-Dimensional Structural Finite Element Program"
HOMEPAGE="http://www.calculix.de/"
SRC_URI="
 http://www.dhondt.de/${MY_P}.src.tar.bz2
 doc? ( http://www.dhondt.de/${MY_P}.ps.tar.bz2 )
 examples? ( http://www.dhondt.de/${MY_P}.test.tar.bz2 )
"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+arpack +doc +examples +lapack +threads"

DEPEND="
 >=sci-libs/arpack-96
 doc? ( virtual/ghostscript )
 virtual/lapack
 >=sci-libs/spooles-2.2
 virtual/blas
"

S=${WORKDIR}/CalculiX

src_unpack() {
	unpack ${A}
}

src_prepare() {
	cd ${MY_P}/src

	ebegin "Patching makefile's {C,F}FLAGS and library paths to not use contrib	stuff, but what we have in system"
	sed -i.bak \
	 -e 's|^CFLAGS.*|CFLAGS = -Wall -O3 -I/usr/include/spooles -DSPOOLES -DARCH="Linux" -DMATRIXSTORAGE -DARPACK $(USE_MT)|g' \
	 -e 's|^FFLAGS.*|FFLAGS = -Wall -O3|g' \
	 -e 's|DIR=.*||g' \
	 -e 's|$(DIR)/spooles.a|$(SPOOLESLIB)|g' \
	 -e 's|../../../ARPACK/libarpack_INTEL.a|-larpack|g' \
	 -e 's|dgesv.f||g' \
	 -e 's|LIBS =|LDFLAGS = $(BLAS) $(LAPACK)|g' \
	 -e 's|\$(LIBS)|$(LDFLAGS)|g' \
	 -e 's|ccx_2.0.a  \$(LDFLAGS)|ccx_2.0.a|g' \
	 Makefile \
	 || die "sed failed"
	eend $?
}

src_compile () {
	export LAPACK=`pkg-config --libs lapack`
	export BLAS=`pkg-config --libs blas`

	export SPOOLESLIB="-lspooles"
	if use threads; then
		export USE_MT="-DUSE_MT"
		export SPOOLESLIB="$SPOOLESLIB -lpthread"
	fi

	cd ${MY_P}/src
	emake || die "emake failed"
}

src_install () {
	cd ${MY_P}/src
	dobin ${MY_P} || die "dobin failed"
	dosym ${MY_P} /usr/bin/ccx

	if use doc; then
		insinto /usr/share/doc/${PF}
		cd "${S}/${MY_P}/doc"
		ps2pdf ${MY_P}.ps ${MY_P}.pdf
		doins ${MY_P}.pdf
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r "${S}"/${MY_P}/test/*
	fi
}

