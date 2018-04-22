# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools git-r3 user

DESCRIPTION="eSpeak NG - reborn of eSpeak TTS (Text-to-Speach engine"
HOMEPAGE="https://github.com/espeak-ng/espeak-ng"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/espeak-ng.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE="+async +extdict-ru +extdict-zh +extdict-zhy +klatt +mbrola +pcaudiolib +sonic"

RDEPEND="pcaudiolib? ( media-sound/pcaudiolib )
	sonic? ( media-sound/sonic )"
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
		$(use_with async) \
		$(use_with extdict-ru) \
		$(use_with extdict-zh) \
		$(use_with extdict-zhy) \
		$(use_with klatt) \
		$(use_with mbrola) \
		$(use_with pcaudiolib) \
		$(use_with sonic)
}

src_compile() {
	emake -j1
}
