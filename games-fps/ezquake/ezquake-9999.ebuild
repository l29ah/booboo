# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games subversion

DESCRIPTION="Quakeworld client with mqwcl functionality and many more features."
HOMEPAGE="http://ezquake.sf.net/"
SRC_URI="nquake? ( http://omploader.org/vM2RzcA -> nquake.7z )"
ESVN_REPO_URI="https://ezquake.svn.sourceforge.net/svnroot/ezquake/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+X svga opengl +nquake"

DEPEND="nquake? ( app-arch/p7zip )"
RDEPEND="
    X? ( x11-libs/libXext )
    svga? ( media-libs/svgalib )
    opengl? (
    	virtual/opengl
		x11-libs/libXxf86dga
    	x11-libs/libXxf86vm
	)"

src_prepare() {
	cd ezquake/libs
	use amd64 && dir=linux-x86_64 || dir=linux-x86
	cd $dir
	cp -l ../../../libs/$dir/* .
	#sh download.sh
}

src_compile() {
	cd ezquake
	use X && flags=x11
	use svga && flags="$flags svga"
	use opengl && flags="$flags glx"
	emake $flags
}

src_install() {
	dodir /opt/quake/ezquake
	use nquake && {
		cd $T;
		p7zip -d "${DISTDIR}"/nquake.7z;
		mv nquake/* $D/opt/quake/;
		cd -;
	}
	cd ezquake

	# Fix paths
	sed -i -e "s|/opt/quake/|$D&|" Makefile

	einstall

	for i in `ls $D/opt/quake/`; do
		dosym /opt/quake/$i /usr/games/bin/$i
	done
	cd ../media/game/
	cp -r * $D/opt/quake/ezquake/
}

