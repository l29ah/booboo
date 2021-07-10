# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Test DRAM for bit flips caused by the rowhammer problem"
HOMEPAGE="https://github.com/google/rowhammer-test"
EGIT_REPO_URI="https://github.com/google/rowhammer-test"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	./make.sh
}

src_install() {
	dobin rowhammer_test
	dobin double_sided_rowhammer
	dodoc README.md
}
