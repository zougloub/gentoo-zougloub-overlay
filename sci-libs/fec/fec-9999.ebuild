EAPI=5
DESCRIPTION="set of functions that implement several popular forward error correction (FEC) algorithms"
HOMEPAGE="https://github.com/quiet/libfec http://www.ka9q.net/code/fec/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/quiet/libfec"

LICENSE="LGPL"
KEYWORDS="~x86 ~amd64"
SLOT=0
IUSE=""
RDEPEND=""
DEPEND=""

inherit git-r3 autotools toolchain-funcs multilib-minimal

src_prepare() {
	sed -i -e 's/"=g"(x) : "r" (x));/"=qhm"(x) : "qh" (x));/' fec.h
}

multilib_src_configure() {
	ECONF_SOURCE=${S}
	econf_build
	sed -i -e "s/\tgcc/\t$(tc-getCC)/" makefile
	sed -i -e "s/CC=gcc/CC=$(tc-getCC)/" makefile
	sed -i -e "s/CFLAGS=.*/CFLAGS=-pipe -Os -fPIC/" makefile
	if [ "${ABI}" == "x86" -a "${ABI}" != "${DEFAULT_ABI}" ]; then
		echo "AS=$(tc-getAS) --32" >> makefile
	fi
}

multilib_src_compile() {
	emake
}

multilib_src_install() {
	dolib libfec.so
	dolib libfec.a
}

