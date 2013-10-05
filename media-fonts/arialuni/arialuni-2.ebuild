# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/liberation-fonts/liberation-fonts-1.04.ebuild,v 1.1 2008/09/30 00:47:30 je_fro Exp $

EAPI=2

inherit font

DESCRIPTION="Arial Unicode MS Font is an extended version of font Arial"
IUSE=""
# I think we can rely on this link
SRC_URI="http://dump.bitcheese.net/files/ysemuga/arialuni.ttf.lzma"
HOMEPAGE="http://support.microsoft.com/?scid=kb%3Bru%3B287247"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="MSttfEULA" # I think we break it...
USE="X"

S=${WORKDIR}
FONT_S=${WORKDIR}

FONT_SUFFIX="ttf"

pkg_postinst() 
{
	einfo "For more information about this font visit this site:"
	einfo "http://www.microsoft.com/typography/fonts/font.aspx?FMID=1081"
	einfo "If you are realy pleased, you can purchase only for 99$"
	einfo "http://www.ascenderfonts.com/font/arial-unicode.aspx"
}
