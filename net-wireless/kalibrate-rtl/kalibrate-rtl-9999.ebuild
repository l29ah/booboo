# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="fork of http://thre.at/kalibrate/ for use with rtl-sdr devices"
HOMEPAGE="https://github.com/steve-m/kalibrate-rtl"
EGIT_REPO_URI="https://github.com/viraptor/kalibrate-rtl"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="net-wireless/rtl-sdr"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
