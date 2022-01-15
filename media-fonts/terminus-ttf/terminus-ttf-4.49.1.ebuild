# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="TTF version of media-fonts/terminus-font"
HOMEPAGE="https://files.ax86.net/terminus-ttf/"
SRC_URI="https://files.ax86.net/${PN}/files/$PV/${P}.zip"

SLOT="0"
LICENSE="OFL-1.1"
KEYWORDS="~amd64 ~x86"

BDEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
