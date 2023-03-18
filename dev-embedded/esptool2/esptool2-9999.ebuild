# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="An esp8266 rom creation tool"
HOMEPAGE="https://github.com/raburton/esptool2"
EGIT_REPO_URI="https://github.com/raburton/esptool2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin esptool2
}
