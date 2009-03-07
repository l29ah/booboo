# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="https://openmw.svn.sourceforge.net/svnroot/openmw/"

DESCRIPTION="OpenMW is an attempt to reimplement the popular role playing game
Morrowind. It aims to be a fully playable, open source implementation of the
game. You must own Morrowind to use OpenMW."
HOMEPAGE="http://openmw.sourceforge.net"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="$RDEPEND"
RDEPEND="
	>=dev-games/ogre-1.4.5
	>=dev-games/ois-1.0.0
	>=sci-physics/bullet-2.72
	media-libs/openal
	|| ( >=dev-lang/dmd-bin-1.036 >=dev-lang/gdc-4.1.3 )
	media-video/ffmpeg
	dev-games/mygui
	"
src_compile() 
{
	make cpp || die "make cpp failed"
	emake all || die "emake failed"
}

src_install() 
{
	emake DESTDIR="${D}" install || die
}  
