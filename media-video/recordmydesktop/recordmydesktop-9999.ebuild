# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/recordmydesktop/recordmydesktop-0.3.8.1.ebuild,v 1.4 2009/03/07 08:55:59 fauli Exp $

EAPI=2
inherit subversion

DESCRIPTION="A desktop session recorder producing Ogg video/audio files"
HOMEPAGE="http://recordmydesktop.sourceforge.net/"
#SRC_URI="mirror://sourceforge/recordmydesktop/${P}.tar.gz"
ESVN_REPO_URI="https://recordmydesktop.svn.sourceforge.net/svnroot/recordmydesktop/trunk/recordmydesktop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="jack alsa"

RDEPEND="x11-libs/libXext
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libICE
	x11-libs/libSM
	media-libs/libogg
	media-libs/libvorbis
	media-libs/libtheora[encode]
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="${RDEPEND}
	=x11-proto/xextproto-7.0.2"

src_configure() {
	sh autogen.sh
	econf $(use_enable jack) $(use_enable !alsa oss)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog TODO
}
