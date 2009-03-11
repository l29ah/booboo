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
#I="/usr/share/games/openmw"
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
# control the dmd version.

src_compile() 
{
	mkdir -p include
	cd include
	ln -s /usr/include/bullet bullet
	cd ..
	cp /usr/lib/*bullet* bullet/
	epatch "${FILESDIR}""/include_dmd.diff" || die "epatch failed"
	emake all || die "emake failed"
	touch ogre.cgf Ogre.log MyGUI.log openmw.ini
}

src_install() 
{
	dodir /usr/share/games/openmw/
		insinto /usr/share/games/openmw/
		doins -r esmtool openmw niftool bsatool bored mscripts media_mygui \
		plugins.cfg.linux ogre.cgf Ogre.log MyGUI.log openmw.ini


			dodir /usr/share/games/openmw/data
			fperms 777 /usr/share/games/openmw/data \
					/usr/share/games/openmw/ogre.cfg \
	                /usr/share/games/openmw/openmw.ini \
	                /usr/share/games/openmw/Ogre.log \
	                /usr/share/games/openmw/MyGUI.log

			fperms +x /usr/share/games/openmw/bored \
				/usr/share/games/openmw/bsatool \
				/usr/share/games/openmw/esmtool \
				/usr/share/games/openmw/niftool \
				/usr/share/games/openmw/openmw
				dobin usr/share/games/openmw/openmw

}
pkg_postinst()
{
	einfo "	Before you can run OpenMW, you have to help it find the Morrowind
	data files. The 'openmw' program needs the files Morrowind.esm and
	Morrowind.bsa, and the directories Sound/ and Music/ from your
	<Morrowind\Data Files\> directory. By default it expects to find these
	in the data/ directory. (This can be changed in openmw.ini)
	I recommend creating a symbolic link to your original Morrowind
	install. For example, if you have Morrowind installed in:'
	'c:\Program Files\Bethesda Softworks\Morrowind\'
	and your windows c: drive is mounted on /media/hda1, then run the
	following command:

	ln -s '/media/hda1/Program Files/Bethesda Softworks/Morrowind/Data Files/*'
	/usr/share/games/data'

	Also, if you have OGRE installed in a non-standard directory (ie. NOT
	in /usr/lib/OGRE), you have to change the PluginFolder in the file
	plugins.cfg.linux.
	The first time you run openmw you will be asked to set screen
	resolution and other graphics settings. You can bring this dialogue up
	at any time with the -oc command line switch. I don't recommend using
	fullscreen mode yet, since it might mess up your screen and input
	settings if the program crashes.
	"
	}





