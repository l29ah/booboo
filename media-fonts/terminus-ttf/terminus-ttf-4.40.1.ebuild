# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit font

DESCRIPTION="Terminus TTF is a TrueType version of Terminus Font, a fixed-width bitmap font optimized for long work with computers."
IUSE=""
SRC_URI="https://files.ax86.net/terminus-ttf/files/$PV/terminus-ttf-$PV.zip"
HOMEPAGE="https://files.ax86.net/terminus-ttf/"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
SLOT="0"
LICENSE="OFL-1.1"
USE="X"

FONT_SUFFIX="ttf"
