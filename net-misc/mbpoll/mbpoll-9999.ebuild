# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="command line utility to communicate with ModBus slave (RTU or TCP)"
HOMEPAGE="https://github.com/epsilonrt/mbpoll"
EGIT_REPO_URI="https://github.com/epsilonrt/mbpoll"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=">=dev-libs/libmodbus-3.1.4"
RDEPEND="${DEPEND}"
