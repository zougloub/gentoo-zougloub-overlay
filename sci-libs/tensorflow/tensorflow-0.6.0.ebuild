# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python2_{6,7} pypy2_0 )

inherit eutils distutils-r1 git-r3

DESCRIPTION="Library for Machine Intelligence"

HOMEPAGE="https://www.tensorflow.org/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/tensorflow/tensorflow"
EGIT_COMMIT="${PV}"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""
RESTRICT="primaryuri"

RDEPEND="
"

DEPEND="
 >=sys-devel/bazel-0.1.1
"

src_prepare() {
	:
}

src_compile() {
	local JAVA_HOME_DECL="$(java-config --print oracle-jdk-bin-1.8 | grep JAVA_HOME)"
	eval "export $JAVA_HOME_DECL"
	
	# Add /proc/self to avoid a sandbox breakage
	local -x SANDBOX_WRITE="${SANDBOX_WRITE}"
	echo "SANDBOX_WRITE=$SANDBOX_WRITE"
	addwrite /proc/self
	
	cat > bazelrc << EOF
startup --batch
build --spawn_strategy=standalone --genrule_strategy=standalone --verbose --verbose_failures
EOF
	export BAZELRC="$PWD/bazelrc"

	bazel build -c opt //tensorflow/tools/pip_package:build_pip_package \
	 || die "Couldn't Bazel build"
}

src_install() {
	:
}

