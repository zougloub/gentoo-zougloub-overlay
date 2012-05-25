# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="program library targeted at the computational solution of partial differential equations using adaptive finite elements"
HOMEPAGE="http://www.dealii.org"
SRC_URI="http://www.dealii.org/download/deal.nodoc-${PV}.tar.gz"


RESTRICT="primaryuri"
LICENSE="QPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+umfpack docs +metis +blas +lapack debug +netcdf arpack trilinos mumps"

S="$WORKDIR/deal.II"

DEPEND="
 dev-libs/boost
 umfpack? ( sci-libs/umfpack )
 metis? ( sci-libs/metis )
 blas? ( virtual/blas )
 lapack? ( virtual/lapack )
 netcdf? ( sci-libs/netcdf )
 arpack? ( sci-libs/arpack )
 trilinos? ( sci-libs/trilinos )
 mumps? ( sci-libs/mumps )
"
RDEPEND="${DEPEND}"

src_configure() {
	./configure \
	 $(use_with umfpack) \
	 $(use_with metis metis-lib) \
	 $(use_with blas) \
	 $(use_with lapack) \
	 $(use_with netcdf) \
	 $(use_with arpack) \
	 $(use_with trilinos) \
	 $(use_with mumps)
}

src_compile() {
	emake optimized || die "emake failed"
	use debug && emake debug
	use doc && emake online-doc
}

src_install() {
	mkdir lib2
	if use debug;
	then
		ln -sf libtbb_debug.so.2 lib2/libtbb_debug.so
	else
		rm -f lib/lib*debug*
	fi

	cp --dereference lib/lib* lib2/
	chmod +x lib2/*
	ln -sf libdeal_II.so.${PV} lib2/libdeal_II.so
	ln -sf libtbb.so.2 lib2/libtbb.so
	dolib lib2/lib*

	dobin lib/bin/*
	insinto /usr/include
	doins -r include/*
	doins -r contrib/tbb/tbb30_104oss/include/tbb
}

