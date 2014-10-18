EAPI=5

inherit multiprocessing subversion

DESCRIPTION="OpenCL documentation (spec, man pages)"
HOMEPAGE="https://www.khronos.org/registry/cl/"
SRC_URI=""

ESVN_USER="anonymous"
ESVN_PASSWORD="anonymous"
ESVN_RESTRICT="export"
ESVN_PROJECT="opencl"
ESVN_REPO_URI="https://cvs.khronos.org/svn/repos/registry/trunk/public/cl"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 >=app-text/dbmathml-1.0
 >=dev-libs/libxslt-1.0.0
"
RDEPEND=""

S="$WORKDIR"

src_compile() {
	local ESVN_LOC="${ESVN_STORE_DIR}/${ESVN_PROJECT}"
	local style="${ROOT}/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl"
	multijob_init
	for rev in 1.0 1.1 1.2 2.0; do
		mkdir -p $rev
		pushd $rev >/dev/null 2>&1
		for file in ${ESVN_LOC}/cl/sdk/${rev}/docs/man/*.xml; do
			multijob_child_init xsltproc --noout --nonet "${style}" "${file}"
		done
		popd >/dev/null 2>&1
	done
	multijob_finish
}

src_install() {
	insinto /usr/share/doc/opencl
	pushd ${ESVN_STORE_DIR}/${ESVN_PROJECT}/cl >/dev/null 2>&1
	doins sdk/1.2/docs/OpenCL-1.2-refcard.pdf
	doins sdk/2.0/docs/OpenCL-2.0-refcard.pdf
	doins -r specs
	doins -r extensions
	popd >/dev/null 2>&1
	cp "${ROOT}/etc/man.conf" ./
	for rev in 1.0 1.1 1.2 2.0; do
		insinto /usr/share/man/mancl${rev}
		pushd $rev >/dev/null 2>&1
		for file in *; do
			sed -i \
			 -e 's/Author: [FIXME: author].*/Author: The Khronos Group Inc./g' \
			 "$file"
			sed -i -e '6,27d' "$file"
			local newfile="${file%.*}.cl${rev}"
			mv "$file" "$newfile"
			doins "$newfile"
		done
		popd >/dev/null 2>&1
		grep "^MANSECT.*:cl${rev}" man.conf >/dev/null \
		 || sed -i -e 's/^\(MANSECT.*\)/\1:cl'${rev}'/g' man.conf
	done
	insinto /etc
	doins man.conf
}

