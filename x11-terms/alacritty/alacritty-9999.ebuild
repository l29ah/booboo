# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cargo git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/jwilm/alacritty"
EGIT_REPO_URI="https://github.com/jwilm/alacritty"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND="
	media-libs/fontconfig"
DEPEND="$CDEPEND
	>=dev-lang/rust-1.15.0"
RDEPEND="${CDEPEND}"
