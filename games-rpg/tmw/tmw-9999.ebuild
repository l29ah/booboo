# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games subversion

ESVN_REPO_URI="http://themanaworld.svn.sourceforge.net/svnroot/themanaworld/tmw/trunk/"
ESVN_BOOTSTRAP="./autogen.sh"
MUSIC="tmwmusic-0.0.20"
SRC_URI="mirror://sourceforge/themanaworld/${MUSIC}.tar.gz"

DESCRIPTION="A fully free and open source MMORPG game with the looks of \"old-fashioned\" 2D RPG"
HOMEPAGE="http://themanaworld.org"

LICENSE="GPL-2"
SLOT="0"
IUSE="opengl"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-games/physfs-1.0.0
    opengl? ( virtual/opengl )
        dev-libs/libxml2
        media-libs/sdl-mixer
        media-libs/sdl-image
        media-libs/sdl-net
        media-libs/sdl-ttf
        net-libs/enet
        net-misc/curl
        >=dev-games/guichan-0.7.0
        dev-util/cvs"


pkg_setup() {
        games_pkg_setup
        if ! built_with_use dev-games/guichan sdl ; then
                eerror "dev-games/guichan needs to be built with USE=sdl"
                die "please re-emerge dev-games/guichan with USE=sdl"
        fi
        if ! built_with_use media-libs/sdl-mixer vorbis ; then
                eerror "media-libs/sdl-mixer needs to be built with USE=vorbis"
                die "please re-emerge media-libs/sdl-mixer with USE=vorbis"
        fi
}

src_unpack() {
        subversion_src_unpack
}

src_compile() {
        egamesconf --disable-dependency-tracking $(use_with opengl) || die
        emake || die
}

src_install() {
        emake DESTDIR="${D}" install || die "make install failed"
        dodoc AUTHORS ChangeLog NEWS README
        cd "${WORKDIR}"
        insinto "${GAMES_DATADIR}"/${PN}/data/music
        doins ${MUSIC}/data/music/*.ogg || die
        newdoc ${MUSIC}/README README.music
        prepgamesdirs
}
