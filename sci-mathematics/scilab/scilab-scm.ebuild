# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# http://bugzilla.scilab.org/

# Main issues:
#  * requires saxon 6.5 to compile help


EAPI=3
inherit eutils autotools java-pkg-2 check-reqs flag-o-matic git

DESCRIPTION="Scientific software package for numerical computations"
LICENSE="CeCILL-2"
HOMEPAGE="http://www.scilab.org/"
SRC_URI=""
EGIT_REPO_URI="git://git.scilab.org/scilab" # http://gitweb.scilab.org/?p=scilab.git;a=summary

SLOT="0"
IUSE="doc fftw +gui hdf5 +matio nls tk +umfpack xcos"
KEYWORDS="~amd64 ~x86"

RDEPEND="
 virtual/lapack
 tk? ( dev-lang/tk )
 xcos? ( dev-lang/ocaml )
 umfpack? ( sci-libs/umfpack )
 gui? (
  >=virtual/jre-1.5
  dev-java/commons-logging
  >=dev-java/flexdock-0.5.2
  dev-java/fop
  dev-java/gluegen
  dev-java/jeuclid-core
  >=dev-java/jlatexmath-0.9.4
  >=dev-java/jgraphx-1.4.1.0
  dev-java/jogl
  dev-java/jgoodies-looks
  dev-java/skinlf
  dev-java/jrosetta
  dev-java/javahelp
  hdf5? ( >=dev-java/hdf-java-1.8.4 )
 )
 fftw? ( sci-libs/fftw:3.0 )
 matio? ( sci-libs/matio )
 hdf5? ( sci-libs/hdf5 )
"

DEPEND="
 ${RDEPEND}
 dev-util/pkgconfig
 doc? (
  app-text/docbook-xsl-stylesheets
  >=dev-java/batik-1.7
  ~dev-java/saxon-6.5.5
 )
"

pkg_setup() {
	#CHECKREQS_MEMORY="512"
	java-pkg-2_pkg_setup
}

src_prepare() {
	cd scilab
	# Increases java heap to 512M when available, when building docs
	#check_reqs_conditional && epatch "${FILESDIR}/java-heap-${PV}.patch"

	ebegin scilab is installed in /usr/lib, not an opt-like folder.
	sed -i -e 's|SCILIB=$SCI/bin:$SCI/lib/scilab/:$SCI/lib64/scilab/|SCILIB=/usr/lib/scilab:/usr/lib64/scilab|' bin/scilab || die
	eend $?

	ebegin Fix jgraphx bad version check
	sed -i -e 's|\[mxGraph.VERSION\],\[\],\[=\]|[mxGraph.VERSION]|' configure.ac || die
	eend $?

	ebegin Fix some java dependency stuff...
	# includes...
	sed -i -e "s|-L\$SCI_SRCDIR/bin/|-L\$SCI_SRCDIR/bin/ -L$(java-config -i gluegen) -L$(java-config -i hdf-java) -L$(java-config -i jogl)|" configure.ac || die
	# and libary paths...
	sed -i \
		-e "/<\/librarypaths>/i\<path value=\"$(java-config -i gluegen)\"\/>" \
		-e "/<\/librarypaths>/i\<path value=\"$(java-config -i jogl)\"\/>" \
		-e "/<\/librarypaths>/i\<path value=\"$(java-config -i hdf-java)\"\/>" \
		etc/librarypath.xml || die
	eend $?

	eautoreconf
	java-pkg-2_src_prepare
}

src_configure() {
	cd scilab
	local myopts
	use doc && myopts="--with-docbook=/usr/share/sgml/docbook/xsl-stylesheets"

	myopts="$myopts --disable-build-help"

	# javac complained about (j)hdf
	use hdf5 && myopts="$myopts --with-hdf5-library=$(java-config -i hdf-java)"

	export JAVA_HOME=$(java-config -O)
	export BLAS_LIBS="$(pkg-config --libs blas)"
	export LAPACK_LIBS="$(pkg-config --libs lapack)"

	# mpi is only used for hdf5 i/o
	if use hdf5 && has_version sci-libs/hdf5[mpi]; then
		export CC=mpicc
		export CXX=mpicxx
		export FC=mpif90
		export F77=mpif77
	fi

	econf \
		--disable-rpath \
		--without-pvm \
		$(use_enable doc build-help) \
		$(use_enable nls) \
		$(use_enable nls build-localization) \
		$(use_with fftw) \
		$(use_with gui)\
		$(use_with gui javasci)\
		$(use_with hdf5) \
		$(use_with matio) \
		$(use_with umfpack) \
		$(use_with tk) \
		$(use_with xcos) \
		${myopts}

	ebegin "Disabling scinotes java build (depends on old saxon)"
	sed -i -e 's/am__append_1 = .*$/am__append_1 = /' modules/scinotes/Makefile
	eend $?

}

src_compile() {
	cd scilab

	emake || die "emake failed"
	if use doc; then
		emake doc || die "emake failed"
	fi
}

src_install() {
	cd scilab

	einstall || die "einstall failed"

	# install docs
	DOCS="ACKNOWLEDGEMENTS README_Unix Readme_Visual.txt"
	dodoc $DOCS || die "failed to install docs"

	newicon icons/scilab.xpm scilab.xpm
	make_desktop_entry ${PN} "Scilab" ${PN}
}

pkg_postinst() {
	einfo "To tell Scilab about your printers, set the environment"
	einfo "variable PRINTERS in the form:"
	einfo
	einfo "PRINTERS=\"firstPrinter:secondPrinter:anotherPrinter\""
}

