EAPI=5

inherit python distutils git-r3

DESCRIPTION="Working on glossarys (dictionary databases) using python"
HOMEPAGE="https://github.com/ilius/pyglossary"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ilius/pyglossary.git"
LICENSE="GPL-3+"
KEYWORDS="~x86 ~amd64"
SLOT="0"
IUSE=""

RESTRICT="primaryuri"

RDEPEND="
"

PYTHON_MODNAME="pyglossary"
SUPPORT_PYTHON_ABIS="2"
RESTRICT_PYTHON_ABIS="3.*"

src_install() {
	distutils_src_install
}

