# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
CMAKE_MAKEFILE_GENERATOR=emake

inherit cmake

DESCRIPTION="A library for decoding various ACARS message payloads"
HOMEPAGE="https://github.com/szpajder/libacars"
SRC_URI="https://github.com/szpajder/libacars/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="
	sys-libs/zlib"
RDEPEND="${DEPEND}"
BDEPEND=""
