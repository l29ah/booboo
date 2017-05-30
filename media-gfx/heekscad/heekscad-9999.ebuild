# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="Computer-Aided Design application based on OCE"
HOMEPAGE="https://github.com/Heeks/heekscad"
EGIT_REPO_URI="https://github.com/Heeks/heekscad"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	sci-libs/oce
	sci-libs/libarea
	>=x11-libs/wxGTK-2.8"
DEPEND="$RDEPEND"
