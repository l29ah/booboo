# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 go

DESCRIPTION="Provides functions to get fixed width of the character or string."
EGO_PACKAGE_PATH="github.com/mattn/go-runewidth"
HOMEPAGE="https://${EGO_PACKAGE_PATH}/"
EGIT_REPO_URI="$HOMEPAGE"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$DEPEND"
