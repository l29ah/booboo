# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils multilib toolchain-funcs multilib-minimal git-r3

DESCRIPTION="a real-time adjustable equalizer plugin for ALSA"
HOMEPAGE="https://github.com/raedwulf/alsaequal"
EGIT_REPO_URI="https://github.com/raedwulf/alsaequal"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=media-libs/alsa-lib-1.0.27.2[${MULTILIB_USEDEP}]
	>=media-plugins/caps-plugins-0.9.15[${MULTILIB_USEDEP}]
	abi_x86_32? ( !<=app-emulation/emul-linux-x86-soundlibs-20130224-r3
					!app-emulation/emul-linux-x86-soundlibs[-abi_x86_32(-)] )"
DEPEND="${RDEPEND}"

DOCS=( README )

src_prepare() {
	eapply -p0 "${FILESDIR}"/${PN}*-asneeded.patch
	default
	multilib_copy_sources
}

multilib_src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall -fPIC -DPIC" \
		LD="$(tc-getCC)" \
		LDFLAGS="${LDFLAGS} -shared" \
		Q= \
		SND_PCM_LIBS="-lasound" \
		SND_CTL_LIBS="-lasound" || die
}

multilib_src_install() {
	exeinto /usr/$(get_libdir)/alsa-lib
	doexe *.so || die
}
