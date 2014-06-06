# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Cursynth is a polyphonic music synthesizer that runs graphically inside your terminal."
HOMEPAGE="https://www.gnu.org/software/cursynth/"
SRC_URI="ftp://ftp.gnu.org/gnu/cursynth/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa jack oss pulseaudio"

DEPEND="
	sys-libs/ncurses
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.8 )"
RDEPEND="${DEPEND}"

src_configure() {
	econf \
		$(use_with jack) \
		$(use_with alsa) \
		$(use_with oss)
}
