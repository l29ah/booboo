# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Matrix Client-Server SDK for Python 2 and 3"
HOMEPAGE="https://github.com/matrix-org/matrix-python-sdk"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3

	EGIT_REPO_URI_ORIG="https://github.com/matrix-org/${PN}.git"
	EGIT_REPO_URI_E2E="https://github.com/Zil0/${PN}.git"
	EGIT_BRANCH_ORIG="master"
	EGIT_BRANCH_E2E="e2e_beta_2"
	src_unpack() {
		if use e2e; then
			EGIT_REPO_URI=${EGIT_REPO_URI_E2E}
			EGIT_BRANCH=${EGIT_BRANCH_E2E}
		else
			EGIT_REPO_URI=${EGIT_REPO_URI_ORIG}
			EGIT_BRANCH=${EGIT_BRANCH_ORIG}
		fi
		git-r3_src_unpack
	}
else
		SRC_URI="https://github.com/matrix-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
		KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="-e2e"

DEPEND="dev-python/canonicaljson
	dev-python/signedjson
	dev-python/unpaddedbase64
	dev-python/frozendict
	dev-python/python-olm
	dev-python/pycrypto"
RDEPEND="${DEPEND}"

python_prepare_all() {
	rm -rf "${S}/test"
	distutils-r1_python_prepare_all
}

