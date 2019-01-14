# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python2_7 python3_6 )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 eutils user

DESCRIPTION="Reference implementation of Matrix homeserver"
HOMEPAGE="https://matrix.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matrix-org/${PN}.git"
else
	SRC_URI="https://github.com/matrix-org/${PV}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"
PATCHES=(
)

CDEPEND=">=dev-python/jsonschema-2.5.1
		>=dev-python/frozendict-1
		>=dev-python/unpaddedbase64-1.1.0
		>=dev-python/canonicaljson-1.1.3
		>=dev-python/signedjson-1.0.0
		>=dev-python/pynacl-1.2.1
		>=dev-python/service_identity-16.0.0
		>=dev-python/twisted-17.1.0
		>=dev-python/treq-15.1
		>=dev-python/pyopenssl-16.0.0
		>=dev-python/pyyaml-3.11
		>=dev-python/pyasn1-0.1.9
		>=dev-python/pyasn1-modules-0.0.7
		>=dev-python/daemonize-2.3.1
		>=dev-python/bcrypt-3.1.0
		>=dev-python/pillow-3.1.2[jpeg]
		>=dev-python/sortedcontainers-1.4.4
		>=dev-python/psutil-2.0.0
		>=dev-python/pysaml2-3.0.0
		>=dev-python/pymacaroons-pynacl-0.9.3
		>=dev-python/msgpack-0.4.2
		>=dev-python/phonenumbers-8.2.0
		>=dev-python/six-1.10
		>=dev-python/prometheus_client-0.0.18
		>=dev-python/attrs-16.0.0
		>=dev-python/netaddr-0.7.18"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}"/synapse.initd synapse
	newconfd "${FILESDIR}"/synapse.confd synapse
}

pkg_postinst() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
}
