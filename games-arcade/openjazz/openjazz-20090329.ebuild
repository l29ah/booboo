# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="OpenJazz is a free, open-source version of the classic Jazz
Jackrabbit™ games."
HOMEPAGE="http://www.alister.eu/jazz/oj/"
SRC_URI="http://www.alister.eu/jazz/oj/OpenJazz-src-290309.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

src_compile() {
	for i in *.cpp
		do g++ -c $i -o ${i/.cpp/.o}
	done
	g++ `pkg-config --libs sdl` *.o -o openjazz
}

RDEPEND="media-libs/libsdl"
DEPEND="$RDEPEND"

