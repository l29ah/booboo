# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit git-r3

DESCRIPTION="RSound is a networked audio system. It allows applications to
transfer their audio data to a different computer."
HOMEPAGE="http://themaister.net/rsound.html"
EGIT_REPO_URI="https://github.com/Themaister/RSound.git"
EGIT_COMMIT="v$PV"
SLOT="0/1.1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa ao openal portaudio pulseaudio oss" # muroar

RDEPEND="media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	ao? ( media-libs/libao )
	openal? ( media-libs/openal )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}"

pkg_setup() {
	DOCS+=" AUTHORS ChangeLog DOCUMENTATION README"
}

src_configure() {
	./configure \
		--prefix="${D}"/usr \
		--disable-roar \
		$(use_enable alsa) \
		$(use_enable ao libao) \
		$(use_enable openal) \
		$(use_enable oss) \
		$(use_enable portaudio) \
		$(use_enable pulseaudio pulse)
}

src_install() {
	emake install
	dodoc AUTHORS ChangeLog DOCUMENTATION README
}
