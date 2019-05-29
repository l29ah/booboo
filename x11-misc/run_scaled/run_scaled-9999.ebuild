# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Run an X application scaled via xpra. Useful on hidpi screens."
HOMEPAGE="https://github.com/kaueraal/run_scaled"
EGIT_REPO_URI="https://github.com/kaueraal/run_scaled"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="x11-wm/xpra"

src_install() {
	dobin run_scaled
	dodoc README.md
}
