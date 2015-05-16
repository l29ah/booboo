# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 go

DESCRIPTION="wego is a weather client for the terminal."
EGO_PACKAGE_PATH="github.com/schachmat/wego"
HOMEPAGE="https://${EGO_PACKAGE_PATH}/"
EGIT_REPO_URI=$HOMEPAGE
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="$DEPEND dev-go/go-colorable"

QA_FLAGS_IGNORED="usr/bin/wego"

src_install() {
	dobin wego
}
