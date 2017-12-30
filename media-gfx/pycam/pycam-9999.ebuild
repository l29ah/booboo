# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python3_5 )

inherit distutils-r1 python-r1

DESCRIPTION="Open Source CAM - Toolpath Generation for 3-Axis CNC machining"
HOMEPAGE="https://github.com/SebKuzminsky/pycam/"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI=https://github.com/SebKuzminsky/pycam/
	inherit git-r3
else
	SRC_URI="https://github.com/SebKuzminsky/pycam/releases/download/v$PV/$P.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pyopengl[${PYTHON_USEDEP}]
	dev-python/urllib3[${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}"
