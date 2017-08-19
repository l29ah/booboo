# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils flag-o-matic linux-info

DESCRIPTION="On board debugger driver for stm32-discovery boards"
HOMEPAGE="https://github.com/texane/stlink"
EGIT_REPO_URI="https://github.com/texane/stlink"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	virtual/libusb"
DEPEND="$RDEPEND
	virtual/libusb
	virtual/pkgconfig"

pkg_pretend() {
	if linux_config_exists; then
		if ! linux_chkconfig_module USB_STORAGE; then
			ewarn "You will need to rebuild usb-storage as a module for v1 stlink to work."
		fi
	fi
}

src_install() {
	cmake-utils_src_install
	cp -r etc $D
	einfo "You may want to run \`udevadm control --reload-rules'."
	dodoc README.md
}
