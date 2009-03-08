# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion

ESVN_REPO_URI="https://my-gui.svn.sourceforge.net/svnroot/my-gui/trunk"

DESCRIPTION="GUI system for OGRE"
HOMEPAGE="http://www.ogre3d.org/wiki/index.php/MyGUI"
SRC_URI=""

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$RDEPEND"
RDEPEND="
	media-libs/freetype
	>=dev-games/ogre-1.4
	"
src_compile() 
{
	chmod +x bootstrap
	./bootstrap || die "bootstrap failed"
	chmod +x configure
	./configure || die "configure failed"
	emake || die "emake failed"
}

src_install() 
{
	emake DESTDIR="${D}" install || die
}  
