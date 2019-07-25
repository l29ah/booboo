# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-info linux-mod git-r3

DESCRIPTION="Intel(R) Software Guard Extensions for Linux* OS"
HOMEPAGE="https://github.com/intel/linux-sgx-driver"
EGIT_REPO_URI="https://github.com/intel/linux-sgx-driver"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

MODULE_NAMES="isgx(kernel/drivers/intel/sgx:${S})"
BUILD_TARGETS="default"
