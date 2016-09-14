# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-r3 go

DESCRIPTION="persistent storage for flags in go"
EGO_PACKAGE_PATH="github.com/schachmat/ingo"
HOMEPAGE="https://${EGO_PACKAGE_PATH}/"
EGIT_REPO_URI="$HOMEPAGE"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$DEPEND"
