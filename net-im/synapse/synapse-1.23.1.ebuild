# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

PYTHON_COMPAT=( python3_8 )
DISTUTILS_SINGLE_IMPL=1
inherit distutils-r1 eutils user

DESCRIPTION="Reference implementation of Matrix homeserver"
HOMEPAGE="https://matrix.org/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/matrix-org/${PN}.git"
else
	SRC_URI="https://github.com/matrix-org/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="ldap"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"
PATCHES=(
)

CDEPEND=">=dev-python/jsonschema-2.5.1
		>=dev-python/frozendict-1
		>=dev-python/unpaddedbase64-1.1.0
		>=dev-python/canonicaljson-1.4.0
		>=dev-python/signedjson-1.1.0
		>=dev-python/pynacl-1.2.1
		>=dev-python/idna-2.5
		>=dev-python/service_identity-18.1.0
		>=dev-python/twisted-18.9.0
		>=dev-python/treq-15.1
		>=dev-python/pyopenssl-16.0.0
		>=dev-python/pyyaml-3.11
		>=dev-python/pyasn1-0.1.9
		>=dev-python/pyasn1-modules-0.0.7
		>=dev-python/bcrypt-3.1.0
		>=dev-python/pillow-4.3.0[jpeg]
		>=dev-python/sortedcontainers-1.4.4
		>=dev-python/pymacaroons-pynacl-0.13.0
		>=dev-python/msgpack-0.5.2
		>=dev-python/phonenumbers-8.2.0
		>=dev-python/prometheus_client-0.4.0
		>=dev-python/attrs-19.1.0
		>=dev-python/netaddr-0.7.18
		>=dev-python/jinja-2.9
		>=dev-python/bleach-1.4.3
		>=dev-python/typing-extensions-3.7.4
		dev-python/simplejson
		ldap? ( dev-python/matrix-synapse-ldap3 )"
DEPEND="${CDEPEND}"
RDEPEND="${CDEPEND}"

python_install_all() {
	distutils-r1_python_install_all
	newinitd "${FILESDIR}"/synapse.initd synapse
}

pkg_preinst() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /var/lib/${PN} ${PN}
	keepdir /var/{run,lib,log}/synapse /etc/synapse
	fowners synapse:synapse /var/{run,lib,log}/synapse /etc/synapse
}

pkg_postinst() {
	einfo "For initial config run"
	einfo "sudo -u synapse python -m synapse.app.homeserver --server-name matrix.domain.tld --config-path /tmp/matrix.domain.tld.yaml --generate-config --report-stats=no"
}
