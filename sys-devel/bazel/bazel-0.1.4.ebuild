# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Bazel build system"
HOMEPAGE="http://bazel.io/"
SRC_URI="https://github.com/bazelbuild/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 virtual/jdk:1.8
"
RDEPEND="${DEPEND}
"

RESTRICT="strip primaryuri"

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	# Force usage of the Oracle 1.8 JDK...
	local JAVA_HOME_DECL="$(java-config --print oracle-jdk-bin-1.8 | grep JAVA_HOME)"
	eval "export $JAVA_HOME_DECL"

	# Add /proc/self to avoid a sandbox breakage
	local -x SANDBOX_WRITE="${SANDBOX_WRITE}"
	addwrite /proc/self

	# And run that ugly compile script
	./compile.sh || die "Couldn't compile"
}

src_install() {
	# Yeah, not so clean
	dobin output/bazel

	mkdir -p ${ED}/usr/lib/${PN}
	tar -h -c base_workspace | tar -C ${ED}/usr/lib/${PN} -x
}

