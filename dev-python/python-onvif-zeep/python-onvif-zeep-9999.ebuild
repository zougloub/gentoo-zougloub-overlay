EAPI=5

PYTHON_COMPAT=( python{2_{5,6,7},3_{2,3,4,5,6}} pypy{1_9,2_0} )

inherit distutils-r1 git-r3

DESCRIPTION="ONVIF Client Implementation"
HOMEPAGE="https://github.com/FalkTannhaeuser/python-onvif-zeep"
EGIT_REPO_URI="git://github.com/FalkTannhaeuser/python-onvif-zeep"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-python/zeep-2.0.0"


