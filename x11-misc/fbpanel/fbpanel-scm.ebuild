EAPI=2
inherit base eutils subversion

DESCRIPTION="light-weight X11 desktop panel"
HOMEPAGE="http://fbpanel.sourceforge.net/"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tbz2"

ESVN_REPO_URI="https://fbpanel.svn.sourceforge.net/svnroot/fbpanel/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~alpha ~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( "CHANGELOG" "CREDITS" "README" )
