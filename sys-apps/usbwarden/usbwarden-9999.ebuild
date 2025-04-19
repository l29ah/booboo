# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v3

EAPI=8

inherit git-r3

DESCRIPTION="Simple script to handle whitelist of allowed usb devices"
HOMEPAGE="https://codeberg.org/gordonq/usbwarden"
EGIT_REPO_URI="https://codeberg.org/gordonq/usbwarden.git"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"

src_install() {
        dobin usbwarden
        dodoc README.md LICENSE
        keepdir /etc/usbwarden
}
