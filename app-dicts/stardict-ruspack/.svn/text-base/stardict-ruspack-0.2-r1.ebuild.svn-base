# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Collection of dicts for stardict."
HOMEPAGE="http://gnome.msiu.ru/stardict.php"
SRC_URI="ftp://ftp.msiu.ru/education/FSF-Windows/stardict/dicts/stardict-dicts.exe"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="app-dicts/stardict
		!app-dicts/stardict-freedict-eng-rus"

DEPEND="app-arch/unrar"

src_install() {
	dodir /usr/share/stardict/dic
	unrar e "${DISTDIR}/stardict-dicts.exe" "${D}/usr/share/stardict/dic/"
}
