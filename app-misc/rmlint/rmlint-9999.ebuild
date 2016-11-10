EAPI=5
PYTHON_COMPAT=( python3_4 python3_5 )

inherit scons-utils eutils git-r3 python-single-r1 gnome2-utils


DESCRIPTION="rmlint finds space waste and other broken things on your filesystem and offers to remove it."
HOMEPAGE="https://github.com/sahib/rmlint"

SRC_URI=""
EGIT_REPO_URI="git://github.com/sahib/rmlint.git"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+gui"

RDEPEND="
 gui? (
  dev-python/pygobject
  x11-libs/gtk+:3
 )
"
DEPEND="
 ${RDEPEND}
 dev-util/scons
 dev-python/sphinx
 sys-devel/gettext
 virtual/libelf
"

GNOME2_ECLASS_GLIB_SCHEMAS=( org.gtk.Settings.FileChooser )

quirk_unset_cflags() {
	ebegin Unsetting CFLAGS because scons is stupid
	unset CFLAGS
	eend
}

src_compile() {
	quirk_unset_cflags
	escons CC="$(tc-getCC)"
}

src_install() {
	quirk_unset_cflags
	escons install LIBDIR=/usr/$(get_libdir) --prefix="${ED}"/usr
}

pkg_postrm() {
	if use gui; then
		gnome2_schemas_update
	fi
}

pkg_postinst() {
	if use gui; then
		gnome2_schemas_update
	fi
}
