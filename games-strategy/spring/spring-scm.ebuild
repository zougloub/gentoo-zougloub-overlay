# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# This ebuild come from http://forums.gentoo.org/viewtopic-t-410834.html - The site http://gentoo.zugaina.org/ only host a copy.
# Small modifications by Ycarus

inherit git games eutils toolchain-funcs

EGIT_REPO_URI="git://github.com/spring/spring.git"
DESCRIPTION="Linux port of a futuristic realtime strategy game in full 3d"
HOMEPAGE="http://springrts.com/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
#~amd64 ~x86"
IUSE="omni optimize unity-lobby"
RESTRICT="nomirror"

RDEPEND="
	!virtual/game_spring
	omni? ( dev-python/wxpython )
	unity-lobby? ( >=dev-python/pygtk-2.10 >=x11-libs/gtk+-2.10 dev-lang/python dev-python/imaging )
	media-libs/glew
	>=media-libs/freetype-2.1.9
	media-libs/devil
	media-libs/openal
	>=dev-libs/boost-1.32.0-r2
	media-libs/jpeg
	media-libs/libsdl
	dev-libs/libaio
"

DEPEND="${RDEPEND}
	dev-util/scons
"

PROVIDE="virtual/game_spring"

#Override src_unpack so it doesn't attempt to unpack the xta mod
src_unpack(){
	unpack spring-linux-data-${MY_PV}.tar.bz2
	subversion_src_unpack
}

src_compile(){
	ewarn	"This ebuild installs directly from a development repository. This means the code might be broken and not compile or -although that's unlikely- somehow damage your setup!"
	einfo	"If anything is not working as expected, consider filing a bug report at the project's website. Don't forget to include appropriate debug information, such as gdb or valgrind backtraces."

	if !(built_with_use dev-libs/boost threads || built_with_use dev-libs/boost threadsonly); then
		eerror "This ebuild detected that dev-libs/boost was built without either the "threads" or "threadsonly" USE-Flag! Thread support needs to enabled in boost for spring to build!"
		eerror "Please run \"echo \"dev-libs/boost threads\" >> /etc/portage/package.use\" and re-emerge dev-libs/boost."
		die
	fi

	if [ $(gcc-major-version) -ge 4 ]; then
		export CXXFLAGS="${CXXFLAGS} -fvisibility=hidden -fpermissive"
	fi

	scons configure $(use debug && echo "debug=1") $(use optimize && echo "optimize=2") prefix="${D}/${GAMES_PREFIX}" datadir="${D}/${GAMES_DATADIR}/${PN}" || die
	(use omni || use unity-lobby) && scons unitsync
	scons || die
}

src_install(){
	newicon "${FILESDIR}/spring.png" ${PN}.png
	make_desktop_entry spring "TA Spring" ${PN}.png

	insinto "${GAMES_DATADIR}/${PN}"
	for subdir in {base,docs,maps,mods,shaders,startscripts}; do
		doins -r "${WORKDIR}/spring-linux-data-${MY_PV}/${subdir}" || die "Datafile ${subdir} install failed"
	done
	for file in {Luxi.ttf,palette.pal,selectkeys.txt,uikeys.txt}; do
		doins "${WORKDIR}/spring-linux-data-${MY_PV}/${file}"
	done

	scons install

	# Bot Config Section
		# AI conf folder
	if [[ -d "${S}/game/AI" ]] ; then
		insinto "${GAMES_DATADIR}/${PN}"
		doins -r game/AI
			# AAI Empty Folders Needed
		dodir "${GAMES_DATADIR}/${PN}/AI/AAI/cache"
		dodir "${GAMES_DATADIR}/${PN}/AI/AAI/log"
		#dodir "${GAMES_DATADIR}/${PN}/AI/AAI/learn"
		dodir "${GAMES_DATADIR}/${PN}/AI/AAI/learn/map"
		dodir "${GAMES_DATADIR}/${PN}/AI/AAI/learn/mod"
	fi

		# JCAI conf
	if [[ -f "${S}/AI/Global/JCAI/settings.cfg" ]] && [[ -d "${S}/AI/Global/JCAI/profiles" ]] ; then
		#dodir "${GAMES_DATADIR}/${PN}/AI/jcai"
		insinto "${GAMES_DATADIR}/${PN}/AI/jcai"
		doins AI/Global/JCAI/settings.cfg
		doins AI/Global/JCAI/profiles/*.cfg
		einfo "Added JCAI AI bot config"
	else
		ewarn "No JCAI AI bot config found in svn checkout"
	fi
	# End of Bot Config Secton

	# unity-lobby
	if use unity-lobby; then
		if [[ -d "${S}/UnityLobby" ]] ; then
			insinto "${GAMES_DATADIR}/${PN}"
			doins -r "UnityLobby"
			insinto "${GAMES_DATADIR}/${PN}/UnityLobby/client"
			fperms ug+x "${GAMES_DATADIR}/${PN}/UnityLobby/Unity.py"
			fperms ug+x "${GAMES_DATADIR}/${PN}/UnityLobby/Profile.py"
			fperms ug+x "${GAMES_DATADIR}/${PN}/UnityLobby/client/main.py"
			echo "#!/bin/sh"$'\n'"python ${GAMES_DATADIR}/${PN}/UnityLobby/Unity.py" > "${D}usr/games/bin/unity-lobby"
			make_desktop_entry unity-lobby "TA Spring - Unity-Lobby" ${PN}.png Game
		else
			ewarn "No Unity-Lobby detected in svn checkout"
		fi
	fi

	# omni
	if use omni; then
		if [[ -d "${S}/omni" ]]; then
			insinto "${GAMES_DATADIR}/${PN}"
			doins -r "${S}/omni" || die "Spring omni install failed"
	                echo "#!/bin/sh"$'\n'"python ${GAMES_DATADIR}/${PN}/omni/omni.py" > "${D}usr/games/bin/spring-omni"
	                make_desktop_entry spring-omni "TA Spring - Omni" ${PN}.png Game "${GAMES_DATADIR}/${PN}/omni"  #Need to set working directory so omni can s$        fi
		else
			ewarn "No omni detected in svn checkout"
		fi
	fi

	#Other
	dodir "${GAMES_DATADIR}/${PN}/demos"
	fperms g+w "${GAMES_DATADIR}/${PN}/demos"

	#Add Config File  /etc/spring/datadir
	insinto /etc/spring
	echo '$HOME/.spring' > ${WORKDIR}/datadir
	echo "${GAMES_DATADIR}/${PN}" >> ${WORKDIR}/datadir
	doins ${WORKDIR}/datadir

	prepgamesdirs
}

pkg_postinst(){
	games_pkg_postinst
	einfo "Installation succeeded!"
	ewarn "Don't forget to run etc-update or dispatch-conf if there are pending config files!"
}

pkg_postrm(){
		if [[ -d "${GAMES_DATADIR}/${PN}" ]] ; then
			ewarn "User added files left behind in" ${GAMES_DATADIR}/${PN}
			einfo "If you are not upgrading Spring, you might want"
			einfo "to type  rm -rv ${GAMES_DATADIR}/${PN}."
			einfo "Otherwise, just ignore this"
		fi
		return
}
