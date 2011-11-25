# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit eutils

DESCRIPTION="A GTK+ 2.6 based XMMS2 client"
SRC_URI="http://wejp.k.vu/files/${P}.tar.gz"
HOMEPAGE="http://wejp.k.vu/projects/xmms2/"
LICENSE="GPL-2"
SLOT="0"
RESTRICT="nomirror"
KEYWORDS="~amd64 ~ppc ~sparc x86 ~hppa ~mips ~ppc64 ~alpha ~ia64"
IUSE=""

RDEPEND="
 >=x11-libs/gtk+-2.6
 >=media-sound/xmms2-0.2.6
"

src_prepare() {
cat << EOF > patch
--- a/gmedialib/gmlplaylists.c   2011-11-24 19:56:37.009141328 -0500
+++ b/gmedialib/gmlplaylists.c       2009-06-08 03:18:46.000000000 -0400
@@ -46,10 +46,10 @@
 			case XMMS_COLLECTION_TYPE_IDLIST:
 				pl_type = "ID list";
 				break;
-			case XMMS_COLLECTION_TYPE_QUEUE:
+			case XMMS_COLLECTION_TYPE_MEDIASET:
 				pl_type = "Queue";
-				break;
-			case XMMS_COLLECTION_TYPE_PARTYSHUFFLE:
+			//	break;
+			//case XMMS_COLLECTION_TYPE_PARTYSHUFFLE:
 				pl_type = "Party shuffle";
 				if (    xmmsv_list_get (xmmsv_coll_operands_get (coll), 0, &v)
 				    &&  xmmsv_get_coll (v, &operand)
EOF
	epatch patch || die "Patch failed"
}

src_compile() {
	sed -i -e "s/\/usr\/local\/bin/\/usr\/bin/g" Makefile
	emake
}

src_install() {
	dodir /usr/bin
	exeinto /usr/bin
	doexe gxmms2
	exeinto /usr/lib/gkrellm2/plugins/
	doexe gkrellxmms2.so
}
