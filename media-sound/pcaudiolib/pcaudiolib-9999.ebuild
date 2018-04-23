# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 user

DESCRIPTION="Portable C Audio Library"
HOMEPAGE="https://github.com/espeak-ng/pcaudiolib"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/pcaudiolib.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="alsa oss pulseaudio"

RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0.18 )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool
	virtual/pkgconfig"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
    econf \
	$(use_with oss) \
	$(use_with alsa) \
	$(use_with pulseaudio)
}

