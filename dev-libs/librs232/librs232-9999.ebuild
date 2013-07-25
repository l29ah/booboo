# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 autotools

DESCRIPTION="multiplatform library for serial communications over RS-232 (serial port)"
HOMEPAGE="https://github.com/ynezz/librs232"
EGIT_REPO_URI="https://github.com/ynezz/librs232.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="lua"

DEPEND="
	virtual/pkgconfig"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable lua)
}
