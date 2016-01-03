# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

EGIT_REPO_URI="https://github.com/lexszero/i3status"

inherit base multilib git-2

DESCRIPTION="Generates status bar to use with dzen2 or xmobar"
HOMEPAGE="http://i3.zekjur.net/i3status/"
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+man pulseaudio"

RDEPEND="
	dev-libs/confuse
	net-wireless/wireless-tools
	media-libs/alsa-lib
	pulseaudio? ( media-sound/pulseaudio )
	"
DEPEND="${RDEPEND}
	man? (
		>=app-text/asciidoc-8.3
		app-text/xmlto
	)
	"
src_prepare() {
	sed -i \
		'\|/usr/share/man/|d' \
		Makefile
}

src_compile() {
	emake WITH_PULSEAUDIO=$(use pulseaudio && echo yes || echo no) ${PN}
	use man && emake -C man
}

src_install() {
	emake DESTDIR="${D}" install
	use man && doman man/*.1
}
