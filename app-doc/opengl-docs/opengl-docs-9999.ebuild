EAPI=5

inherit multiprocessing subversion

DESCRIPTION="OpenGL man pages"
HOMEPAGE="http://www.opengl.org/wiki/Getting_started/XML_Toolchain_and_Man_Pages"
SRC_URI=""

ESVN_USER="anonymous"
ESVN_PASSWORD="anonymous"
ESVN_PROJECT="opengl-manpages"
ESVN_RESTRICT="export"

LICENSE="FreeB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
 >=app-text/dbmathml-1.0
 >=dev-libs/libxslt-1.0.0
"
RDEPEND=""

S="$WORKDIR"

src_unpack() {
	for repo in mancommon man4 man3 man2 manglsl reference_card;
	do
		local ESVN_REPO_URI=https://cvs.khronos.org/svn/repos/ogl/trunk/ecosystem/public/sdk/docs/$repo
		subversion_fetch || die "Failed to fetch $repo"
	done
}

src_compile() {
	local style="${ROOT}/usr/share/sgml/docbook/xsl-stylesheets/manpages/docbook.xsl"
	multijob_init
	# Compile man pages
	for repo in mancommon man4 man3 man2 manglsl;
	do
		mkdir -p $repo
		pushd $repo >/dev/null 2>&1
		for file in ${ESVN_STORE_DIR}/${ESVN_PROJECT}/$repo/*.xml; do
			local base="$(basename ${file})"
			multijob_child_init xsltproc --noout --nonet "$style" "$file"
		done
		popd >/dev/null 2>&1
	done
	multijob_finish
}


src_install() {
	local -A secmap=([mancommon]=gl [man2]=gl2 [man3]=gl3 [man4]=gl4 [manglsl]=glsl)
	cp "${ROOT}/etc/man.conf" ./
	for repo in mancommon man4 man3 man2 manglsl;
	do
		local rep="${secmap[$repo]}"
		insinto "/usr/share/man/man${rep}"

		if grep "^MANSECT.*:${rep}" man.conf >/dev/null;
		then
			einfo "Section $rep of man pages already here"
		else
			einfo "Adding section $rep into man.conf"
			sed -i -e 's/^\(MANSECT.*\)/\1:'${rep}'/g' man.conf
		fi

		pushd "$repo" >/dev/null 2>&1
		ebegin "Processing folder $repo ($(ls -1 | wc -l) files)"
		for file in $(ls -1); do
			local newfile="${file%.*}.${rep}"
			mv "$file" "$newfile"
			doins "$newfile"
		done
		eend 0
		popd >/dev/null 2>&1
	done
	insinto /etc
	doins man.conf
}

