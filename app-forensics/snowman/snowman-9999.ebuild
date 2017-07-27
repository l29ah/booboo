# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

if [[ ${PV} == *9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	EGIT_COMMIT="v${PV}"
fi

DESCRIPTION="A native code to C/C++ decompiler"
HOMEPAGE="https://derevenets.com/"
EGIT_REPO_URI="https://github.com/yegord/snowman.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

CMAKE_USE_DIR="${S}/src"
#CMAKE_MAKEFILE_GENERATOR=ninja
