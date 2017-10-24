# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit git-2

DESCRIPTION="Portland utils for cross-platform/cross-toolkit/cross-desktop interoperability"
HOMEPAGE="http://portland.freedesktop.org/"
SRC_URI="" # "http://portland.freedesktop.org/download/${MY_P}.tar.gz"
EGIT_REPO_URI="git://anongit.freedesktop.org/xdg/xdg-utils"
LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="doc"

RDEPEND="
 dev-util/desktop-file-utils
 dev-perl/File-MimeInfo
 x11-misc/shared-mime-info
 x11-apps/xprop
 x11-apps/xset"
DEPEND=""

DOCS=( ChangeLog README RELEASE_NOTES TODO )

src_test() { :; } # write access as root outside of sandbox required

SCRIPTS="$(eval echo xdg-{desktop-{menu,icon},mime,icon-resource,open,email,screensaver,settings,su,copy,file-dialog,terminal})"

src_compile() {
	emake
	emake -C scripts scripts SCRIPTS="$SCRIPTS"
}

src_install() {
	emake install DESTDIR="$IMAGE" SCRIPTS="$SCRIPTS"

	newdoc scripts/README README.scripts
	use doc && dohtml -r scripts/html

	# Install default XDG_DATA_DIRS, bug #264647
	echo 'XDG_DATA_DIRS="/usr/local/share"' > 30xdg-data-local
	echo 'COLON_SEPARATED="XDG_DATA_DIRS XDG_CONFIG_DIRS"' >> 30xdg-data-local
	doenvd 30xdg-data-local

	echo 'XDG_DATA_DIRS="/usr/share"' > 90xdg-data-base
	echo 'XDG_CONFIG_DIRS="/etc/xdg"' >> 90xdg-data-base
	doenvd 90xdg-data-base
}

pkg_postinst() {
	[[ -x $(type -P gtk-update-icon-cache) ]] || elog "Install x11-libs/gtk+:2 for the gtk-update-icon-cache command."
}

