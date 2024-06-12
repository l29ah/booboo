# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..13} )

inherit python-r1 linux-info systemd

DESCRIPTION="Fix Intel CPU Throttling on Linux"
HOMEPAGE="https://github.com/erpalma/throttled"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
	EGIT_BRANCH="master"
else
	MY_P="v${PV}"
	SRC_URI="https://github.com/erpalma/${PN}/archive/${MY_P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
"

CONFIG_CHECK="X86_MSR DEVMEM"

src_prepare() {
	default
	sed -i -e "s/ExecStart=.*/ExecStart=${PN}/" systemd/throttled.service
}

src_install() {
	default
	python_foreach_impl python_domodule mmio.py
	python_foreach_impl python_newscript throttled.py ${PN}
	dodoc README.md
	insinto /etc/
	doins etc/throttled.conf
	doinitd "${FILESDIR}"/"${PN}"
	systemd_newunit "${S}/systemd/throttled.service" "${PN}".service
}
