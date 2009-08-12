EAPI=2
DESCRIPTION="Library for reading and writing matlab .MAT files"
HOMEPAGE="http://sourceforge.net/projects/matio"
ESVN_REPO_URI="https://matio.svn.sourceforge.net/svnroot/matio/trunk"
LICENSE="LGPL-2.1"
KEYWORDS="~x86"
SLOT=0
IUSE="+doc +examples fortran"

inherit eutils subversion autotools

RDEPEND="
"

DEPEND="
 doc? ( app-doc/doxygen virtual/latex-base )
 $RDEPEND
"

src_prepare() {
	eautoreconf
}

pkg_setup() {
	use fortran && fortran_pkg_setup
}

src_configure() {
	econf \
	 $(use_enable test) \
	 $(use_enable doc docs) \
	 || die "econf failed"
}

src_test() {
	./test/test_mat || die "mat test failed"
	./test/test_snprintf || die "snprintf test failed"
}

src_install() {
	einstall docdir=${D}/usr/share/doc/${PF} || die "einstall failed"

	dodoc README ChangeLog
	doman doxygen/man/man3/*

	if use doc;
	then
		insinto /usr/share/doc/${PF}
		doins -r doxygen/html
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins test/test*
		#insinto /usr/share/${PF}
		doins share/test*
	fi
}

