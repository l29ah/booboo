# Copyright 2021 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=7

DESCRIPTION="Virtual to select between different udev daemon providers"
SLOT="0"

RDEPEND="
	|| (
		>=sys-fs/udev-217
		>=sys-fs/eudev-2.1.1
		>=sys-apps/systemd-217
		=sys-fs/udev-zero-9999
	)
"
