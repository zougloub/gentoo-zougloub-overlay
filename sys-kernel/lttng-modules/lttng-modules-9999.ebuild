# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit toolchain-funcs eutils git-2 linux-mod

DESCRIPTION="Modules for LTTng, linux tracer"
HOMEPAGE="http://lttng.org/lttng2.0"
SRC_URI=""

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
"
RDEPEND="${DEPEND}"

EGIT_REPO_URI="git://git.lttng.org/lttng-modules.git"
EGIT_BRANCH="master"

MODULE_NAMES="ltt-relay(misc:${S}:${S}) lib-ring-buffer(misc:${S}:${S}/lib)"
for mod in ftrace kprobes kretprobes probe-block probe-irq probe-kvm probe-lttng probe-sched types;
do
	MODULE_NAMES="$MODULE_NAMES lttng-${mod}(misc:${S}:${S}/probes)"
done

for mod in client-discard client-mmap-discard client-mmap-overwrite \
	client-overwrite metadata-mmap-client client-overwrite metadata-client
do
	MODULE_NAMES="$MODULE_NAMES ltt-ring-buffer-$mod(misc:${S}:${S})"
done

BUILD_TARGETS="default"

pkg_setup() {
	linux-mod_pkg_setup
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
	dodoc README ChangeLog
}

