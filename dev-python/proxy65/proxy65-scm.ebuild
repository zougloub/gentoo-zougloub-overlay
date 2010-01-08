# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=2

inherit subversion twisted

#distutils

DESCRIPTION="The proxy65 project is an external component (written on top of the Twisted Python library) that can be hooked up to existing Jabber/XMPP server to provide SOCKS5 Bytestreams functionality for file transfer between Jabber users, as specified in XEP-0065"
HOMEPAGE="http://code.google.com/p/proxy65/"
SRC_URI=""
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
SLOT="0"
EAPI="2"
IUSE=""
ESVN_REPO_URI="http://proxy65.googlecode.com/svn/trunk/"

RDEPEND="
 dev-python/twisted
"

DEPEND="
 $RDEPEND
"

PYTHON_MODNAME="twisted/plugins twisted/proxy65"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

src_unpack() {
	subversion_src_unpack
}

#src_install() {
#	distutils_src_install
#}

