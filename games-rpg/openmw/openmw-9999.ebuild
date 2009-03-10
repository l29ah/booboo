# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ booboo/games-rpg/openmw/openmw-9999.ebuild
# modified at < 11-03-09/01:10 > 
# email < MiklerGM@gmail.com >


inherit subversion

ESVN_REPO_URI="https://openmw.svn.sourceforge.net/svnroot/openmw/trunk/"

DESCRIPTION="OpenMW is an attempt to reimplement the popular role playing game
Morrowind. It aims to be a fully playable, open source implementation of the
game. You must own Morrowind to use OpenMW."
HOMEPAGE="http://openmw.sourceforge.net"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
# if you want to use GDC you need to edit the patch (remove the changes in Makefile). later i'll fix this.
DEPEND="$RDEPEND"
RDEPEND="
	>=dev-games/ogre-1.4.5
	>=dev-games/ois-1.0.0
	>=sci-physics/bullet-2.72
	media-libs/openal
	|| ( dev-lang/dmd-bin >=dev-lang/gdc-4.1.3 )
	media-video/ffmpeg
	dev-games/mygui
	"
# use overlay "d" to install dmd-bin
# http://www.dsource.org/projects/tango/wiki/GentooLinux read this manual,
# but i use the "phobos" library as primary. Later, i think, i add use-flags to
# control the dmd version. Maybe and dmd ebuild in this overlay

src_compile() 
{
	mkdir -p include
	cd include
	ln -s /usr/include/bullet bullet
	cd ..
	cp /usr/lib/*bullet* bullet/
	epatch "${FILESDIR}""/include_dmd.diff" || die "epatch failed"
	emake all || die "emake failed"
}

src_install() 
{
	dodir /share/games/openmw/
		insinto /usr/share/games/openmw/
		doins -r * 
#	dobin /usr/share/games/openmw/openmw
}
# here i need to save permission's for each file but i don't now how i can do
# this correctly. Maybe try such thing as 'fowners' or 'fperms'. 
# or use the patch to repair permissions


