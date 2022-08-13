# Copyright 1999-2202 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake

EGIT_REPO_URI="https://github.com/equalsraf/neovim-qt.git"

DESCRIPTION="GUI version of the Neovim text editor"
HOMEPAGE="https://github.com/equalsraf/neovim-qt/wiki"
SRC_URI=""

LICENSE="ISC"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="${RDEPEND}"
RDEPEND="app-editors/neovim
dev-qt/qtgui:5
dev-qt/qtwidgets:5
dev-qt/qtnetwork:5
dev-qt/qtcore:5
"
