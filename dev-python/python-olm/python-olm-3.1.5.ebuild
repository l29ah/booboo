# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..11} )
inherit distutils-r1

DESCRIPTION="Python bindings for the Olm C library"
HOMEPAGE="https://gitlab.matrix.org/matrix-org/olm/tree/master/"
if [[ ${PV} == 9999 ]]; then
        inherit git-r3
        EGIT_REPO_URI="https://gitlab.matrix.org/matrix-org/olm.git"
else
        SRC_URI="https://gitlab.matrix.org/matrix-org/olm/-/archive/${PV}/olm-${PV}.tar.bz2"
        KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
S="${WORKDIR}/olm-${PV}/python"

DEPEND="dev-python/cffi
	dev-libs/olm
	dev-python/pip[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"
