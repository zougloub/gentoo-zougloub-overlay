# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit golang-build git-r3

KEYWORDS="~amd64"
EGO_PN="github.com/odeke-em/drive/..."
SRC_URI=""
EGIT_REPO_URI="git://github.com/odeke-em/drive"
DESCRIPTION="Google Drive client for the commandline"
HOMEPAGE="https://${EGO_PN%/*}"
LICENSE="Apache-2.0"
RESTRICT="primaryuri"
SLOT="0/${PVR}"
IUSE=""

RDEPEND="
 >=dev-lang/go-1.7.0
"

DEPEND="
 $RDEPEND
"

src_unpack() {
	git-r3_src_unpack
	ebegin "Go get"
	GOPATH="${WORKDIR}/${P}" \
	 go get -d github.com/odeke-em/drive/cmd/drive
	GOPATH="${WORKDIR}/${P}" \
	 go get -d github.com/odeke-em/ripper
	GOPATH="${WORKDIR}/${P}" \
	 go get -d github.com/go-martini/martini
	GOPATH="${WORKDIR}/${P}" \
	 go get -d github.com/martini-contrib/binding
	GOPATH="${WORKDIR}/${P}" \
	 go get -d github.com/odeke-em/rsc
	eend 0
}

src_prepare() {
	rm -rf "${S}/src/${EGO_PN%/*}/drive-gen/Godeps/_workspace" || die
}

src_compile() {
	GOPATH="${WORKDIR}/${P}" \
		go install -v -work -x ${EGO_BUILD_FLAGS} "${EGO_PN}" || die
}

src_install() {
	dodoc "${S}/src/${EGO_PN%/*}/README.md"
	golang_install_pkgs
}

golang_install_pkgs() {
	insopts -m0644 -p # preserve timestamps for bug 551486
	dobin "${S}/bin/drive"{,-server}
	insinto "$(dirname "${EPREFIX}$(get_golibdir)/pkg/$(go env GOOS)_$(go env GOARCH)/${EGO_PN%/*}")"
	doins -r "${S}"/pkg/$(go env GOOS)_$(go env GOARCH)/${EGO_PN%/*}
	insinto "$(dirname "${EPREFIX}$(get_golibdir)/src/${EGO_PN%/*}")"
	doins -r "${S}"/src/${EGO_PN%/*}
}
