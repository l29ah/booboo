# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DICT_P="stardict-comn_sdict05_czech-rus-$PV"
FROM_LANG=Czech
TO_LANG=Russian

inherit stardict

HOMEPAGE="https://sourceforge.net/projects/xdxf/"
SRC_URI="mirror://sourceforge/project/xdxf/dicts-stardict-form-xdxf/002c/${DICT_P}.tar.bz2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

S="$WORKDIR/stardict-czech-rus-$PV"
