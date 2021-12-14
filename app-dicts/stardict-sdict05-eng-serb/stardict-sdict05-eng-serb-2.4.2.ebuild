# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DICT_P="stardict-comn_sdict_axm05_eng_serb-$PV"
FROM_LANG=Czech
TO_LANG=Russian

inherit stardict

HOMEPAGE="https://sourceforge.net/projects/xdxf/"
SRC_URI="mirror://sourceforge/xdxf/${DICT_P}.tar.bz2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"

S="$WORKDIR/stardict-eng_serb-$PV"
