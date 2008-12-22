# Copyright 2005-2007 David Somers (dsomers AT omz13 DOT com)
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils libtool

DESCRIPTION="CVSNT - source code revision control tools"
HOMEPAGE="http://www.cvsnt.org/wiki"
SRC_URI="http://www.cvsnt.org/archive/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

FEATURES="test"

IUSE="doc kerberos pam ssl server odbc mysql postgres"

DEPEND="
 virtual/libc
 >=dev-libs/libxml2-2.7.2
 >=sys-libs/zlib-1.1.4
 >=dev-libs/libpcre-6.1
 >=dev-libs/expat-1.95.8
 ssl? ( >=dev-libs/openssl-0.9.7d )
 kerberos? ( virtual/krb5 )
 pam? ( >=sys-libs/pam-0.73 >=sys-apps/shadow-4.0.2-r2 )
 doc? ( >=app-text/xmlto-0.0.18 >=app-text/docbook-xsl-stylesheets-1.66.1 )
 server? (
  >=net-misc/mDNSResponder-107.1
  odbc? ( >=dev-db/unixODBC-2.2.8 )
  mysql? ( >=dev-db/mysql-4.1.14 )
  postgres? ( >=dev-db/postgresql-8.1.1 )
 )
"


RDEPEND="
 $DEPEND
 server? ( >=sys-apps/xinetd-2.3.13 )
"

src_unpack() {
	unpack ${A}

	elibtoolize

	if use doc; then
		cd ${S}/doc
		# now splat the version number in the manuals
		sed "s/__VERSION__/${PV}/" < cvs.dbk > cvs2.dbk || die "sed tweaking of cvs.dbk failed"
		sed "s/__VERSION__/${PV}/" < cvsclient.dbk > cvsclient2.dbk || die "sed tweaking of cvsclient.dbk failed"
		cd ${S}
		# tweak the top-level makefile so that it doens't try to install any files into the config-dir - this ebuild does that instead
		sed -i "s/@INSTALL_SERVER_TRUE@/#/" Makefile.in || die "sed tweaking of Makefile.in failed"
	fi

#	cd ${S}/cvsapi/db/postgres
#	epatch ${FILESDIR}/cvsnt-2.5.04.2461-extraqualif.patch || die "extra qualification patch failed"
}

src_compile() {
	# FYI, cvsnt has the following enable/disable options:
	# pam (note: needs PAM libs and headers)
	# server
	# lockserver
	# pserver
	# ext
	# fork (note: default is DISABLED)
	# rsh
	# gserver (note: needs MIT Kerberos V5 libs and headers)
	# sserver (note: needs OpenSSL libs and header)
	# sspi
	# cvsgui
	# rcs

	econf \
		--with-tmpdir=/tmp \
		--enable-enum \
		`use_enable pam` \
		`use_enable ssl sserver` \
		`use_enable kerberos gserver` \
		`use_enable odbc` \
		`use_enable mysql` \
		`use_enable postgres` \
		|| die
	cd ${S}/protocols/ntlm

	cd ${S}/ufc-crypt
	make || die "make ufc-crypt failed"

	emake || die "emake failed"

	if use doc; then
		cd ${S}/doc
		xmlto --skip-validation -o html_cvs html cvs2.dbk || die "failed to build html flavour of cvs manual"
		xmlto --skip-validation -o html_cvsclient html cvsclient2.dbk || die "failed to build html flavour of cvsclient manual"
	fi
}

src_install() {
#	einstall || die
	 make DESTDIR="${D}" install || die "install failed"

	# cvsntpserver runs under xinetd.d
	insinto /etc/xinetd.d
	doins ${FILESDIR}/cvspserver || die "doins /etc/xinetd.d/cvspserver failed"

	# cvslockd
	exeinto /etc/init.d
	newexe ${FILESDIR}/cvslockd4 cvslockd

	# example config files
	if use server; then
		insinto /etc/cvsnt
		doins ${S}/doc/PServer.example || die "doins /etc/cvsnt/PServer.example failed"
		doins ${S}/doc/Plugins.example || die "doins /etc/cvsnt/Plugins.example failed"
	fi
	# the client needs ca.pem, otherwise it is unable to validate the cert chain
	# when attempting a secured (ssl) connection
	insinto /etc/cvsnt
	doins ${S}/ca.pem || die "doins /etc/cvsnt/ca.pem failed"

	# basic documentation
	dodoc ChangeLog* FAQ INSTALL README

	# full documentation
	if use doc; then
		insinto /usr/share/doc/${PF}/html/cvs
		doins ${S}/doc/html_cvs/* || die "doins html cvs failed"
		insinto /usr/share/doc/${PF}/html/cvsclient
		doins  ${S}/doc/html_cvsclient/* || die "doins html cvsclient failed"
	fi

	# pam
	if use pam; then
		insinto /etc/pam.d
		newins ${FILESDIR}/cvsnt.pam cvs || die "newins /etc/pam.d/cvsnt failed"
	fi

	if use server; then
		insinto /usr/share/${PF}
		doins ${S}/triggers/sql/*
	fi
}

pkg_preinst() {
# if already installed, try stopping the lock server before installing
		if [ -f /etc/init.d/cvslockd ] ; then
			if [ -f  /var/run/cvslockd.pid ] ; then
				/etc/init.d/cvslockd stop
			fi
		fi
}

pkg_postinst() {
	einfo "If you are using cvsnt as a server, don't forget to:"
	einfo "1. customize /etc/cvsnt/PServer"
	einfo "   set Repository0/Repository0Name, etc."
	einfo "   (use /etc/cvsnt/PServer.example as a start)"
	einfo "2. customize /etc/xinetd.d/cvsntpserver"
	einfo "   change disable = yes to disable = no"
	einfo "   tweak only_from as applicable"
	einfo "3. do '/etc/init.d/xinetd restart'"
	einfo "4. do 'rc-update add cvslockd default'"
	einfo "5. do '/etc/init.d/cvslockd start'"
	einfo "6. setup your initial repository"
	einfo "   (hint: cvs -d :local:/path/to/new/repository init)"
	einfo ""
	if use server; then
	einfo "For database audit/log/etc., if not previously done,"
	einfo "execute the appropriate sql script in /usr/share/${PF}"
	fi
}
