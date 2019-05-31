# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit git-r3 distutils-r1

DESCRIPTION="Host applications and library for Crazyflie written in Python."
HOMEPAGE="https://github.com/bitcraze/crazyflie-clients-python"
EGIT_REPO_URI="https://github.com/bitcraze/crazyflie-clients-python"
EGIT_COMMIT=2017.06.1

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# cflib is pinned since it doesn't provide positional feedback on the latter versions
DEPEND="
	=dev-python/cflib-0.1.3[${PYTHON_USEDEP}]
	dev-python/pyqtgraph[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eapply "${FILESDIR}/0001-Update-appdirs-dependency-to-1.4.0.patch"
}
