# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Dirk Göttel <dgoettel@freenet.de>
# $Header:

inherit gnome2

DESCRIPTION="A full featured, dual-pane file manager for Gnome2"
HOMEPAGE="http://www.nongnu.org/gcmd/"

SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/1.2/${P}.tar.bz2";

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

LICENSE="GPL-2"

IUSE="doc exif iptc id3 gsf"
SLOT="0"

RDEPEND=">=x11-libs/gtk+-2.6.0
	>=gnome-base/gnome-vfs-2.0
	>=dev-libs/glib-2.0.0
	>=gnome-base/libgnomeui-2.0
	>=gnome-base/gconf-2.0
	>=dev-lang/python-2.4
	|| (
		app-admin/gamin
		app-admin/fam
	)
	exif? ( >=media-libs/libexif-0.6.12 )
	iptc? ( >=media-libs/libiptcdata-0.2.1 )
	id3?  ( >=media-libs/id3lib-3.8.3 )
	gsf?  ( >=gnome-extra/libgsf-1.12.0 )"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"


DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

pkg_setup() {
        G2CONF=" ${G2CONF}
                $(use_with exif libexif)
                $(use_with iptc libiptcdata)
                $(use_with id3 id3lib)
                $(use_with doc docs)
                $(use_with gsf libgsf)"
}
