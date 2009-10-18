EAPI=2

inherit eutils autotools gnome2 flag-o-matic git

DESCRIPTION="A full featured, dual-pane file manager for Gnome2"
HOMEPAGE="http://www.nongnu.org/gcmd/"

SRC_URI=""
EGIT_REPO_URI="git://git.gnome.org/gnome-commander"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

LICENSE="GPL-2"

IUSE="doc +exif +gsf +id3 +python"
SLOT="0"

RDEPEND="
 >=x11-libs/gtk+-2.8.0
 >=dev-libs/glib-2.6.0
 >=gnome-base/libgnomeui-2.4.0
 >=gnome-base/libgnome-2.0.0
 >=gnome-base/gnome-vfs-2.0.0
 || (
  app-admin/gamin
  app-admin/fam
 )
 exif?   ( >=media-gfx/exiv2-0.14     )
 gsf?    ( >=gnome-extra/libgsf-1.12.0 )
 id3?    ( >=media-libs/taglib-1.4  )
 python? ( >=dev-lang/python-2.4    )
"

DEPEND="
 ${RDEPEND}
 >=dev-util/intltool-0.35.0
 dev-util/pkgconfig
"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

src_prepare() {
	
	ebegin "Working around intltool issue"
	sed -i.bak "s:IT_PROG_INTLTOOL.*::g" configure.in
	eend $?

	for file in Makefile.in Makefile.in.in;
	do
		if [ ! -a po/$file ];
		then
			ebegin "Fixing po/$file not existing issue"
			echo -e "all:\n\ninstall:\n\n" > po/$file
			eend $?
		fi
	done

	ebegin "Working around second intltool issue"
	sed -i.bak "s:@INTLTOOL_DESKTOP_RULE@::g" data/Makefile.am
	echo -e "gnome-commander.desktop: gnome-commander.desktop.in\n\tcat \$< > \$@\n\n" >> data/Makefile.am
	eend $?

	eautoreconf || die "eautoreconf failed"
}

pkg_setup() {
	G2CONF="
	 ${G2CONF}
	 $(use_with exif exiv2)
	 $(use_with gsf  libgsf)
	 $(use_with id3  taglib)
	 $(use_enable python python)
	"
	filter-ldflags -Wl,--as-needed
}

