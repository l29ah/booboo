# Copyright 2026 ReK2 - Chris F.N. <rek2@hispagatos.org>
# https://rek2.hispagatos.org
# Distributed under the terms of the GNU General Public License v3

EAPI=8

DISTUTILS_USE_PEP517=setuptools
# add python3_15/python3_16 here once Gentoo's python-r1 eclass supports them
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1 systemd git-r3

DESCRIPTION="Self-configuring, encrypted and resilient mesh networking stack for LoRa, packet radio, WiFi and more"
HOMEPAGE="https://reticulum.network/ https://github.com/markqvist/Reticulum"
EGIT_REPO_URI="https://github.com/markqvist/Reticulum.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="systemd"

RDEPEND="
	acct-user/reticulum
	>=dev-python/cryptography-3.4.7[${PYTHON_USEDEP}]
	>=dev-python/pyserial-3.5[${PYTHON_USEDEP}]
"

# tests seem broken
#distutils_enable_tests unittest

src_install() {
	distutils-r1_src_install

	newconfd "${FILESDIR}"/rnsd.confd rnsd
	newinitd "${FILESDIR}"/rnsd.initd rnsd
	use systemd && systemd_dounit "${FILESDIR}"/rnsd.service

	keepdir /etc/reticulum
	keepdir /var/log/reticulum
	fowners reticulum:reticulum /etc/reticulum
	fowners reticulum:reticulum /var/log/reticulum
}
