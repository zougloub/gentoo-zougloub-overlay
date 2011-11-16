EAPI=3

inherit eutils git-2

DESCRIPTION="FuseCompress - compresses filesystem"
HOMEPAGE="http://www.miio.net/fusecompress/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/tex/fusecompress.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
 >=sys-fs/fuse-2.6
 >=app-arch/bzip2-1.0.3-r5
 >=sys-libs/zlib-1.2.3
 >=dev-libs/lzo-2.02
 >=dev-libs/rlog-1.3.7
 >=dev-libs/boost-1.33.1
 || (
  app-arch/lzma-utils
  app-arch/xz-utils
 )
"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc ChangeLog README
}

