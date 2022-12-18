# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{5..11} )

inherit git-r3 distutils-r1

DESCRIPTION="Host applications and library for Crazyflie written in Python."
HOMEPAGE="https://github.com/bitcraze/crazyflie-clients-python"
EGIT_REPO_URI="https://github.com/bitcraze/crazyflie-clients-python"
EGIT_COMMIT="$PV"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
	dev-python/cflib[${PYTHON_USEDEP}]
	dev-python/pyqtgraph[${PYTHON_USEDEP}]
	dev-python/appdirs[${PYTHON_USEDEP}]
	dev-python/pyzmq[${PYTHON_USEDEP}]
	dev-python/cx_Freeze[${PYTHON_USEDEP}]
	dev-python/qtm[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
