# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 user

DESCRIPTION="Simple library to speed up or slow down speech"
HOMEPAGE="https://github.com/espeak-ng/sonic"
SRC_URI=""
EGIT_REPO_URI="https://github.com/espeak-ng/sonic.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="sci-libs/fftw"
DEPEND="${RDEPEND}"

src_prepare() {
    cd "${WORKDIR}"/${P} || die
	epatch "${FILESDIR}"/${P}-fix-lib.patch

	eapply_user
}

src_install() {
	emake DESTDIR="${D}" SONIC_LIBDIR="$(get_libdir)" install
}
