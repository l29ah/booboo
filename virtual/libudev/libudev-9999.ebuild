# Copyright 2021 Your Mom
# Distributed under the terms of the GNU General Public License v3

EAPI=7

inherit multilib-build

DESCRIPTION="Virtual for libudev providers"

SLOT="0/1"
IUSE="static-libs systemd"

RDEPEND="
	!systemd? ( || (
		>=sys-fs/udev-232:0/0[${MULTILIB_USEDEP},static-libs(-)?]
		>=sys-fs/eudev-3.2.9:0/0[${MULTILIB_USEDEP},static-libs(-)?]
		=sys-fs/udev-zero-9999:0/1[${MULTILIB_USEDEP},static-libs(-)?]
	) )
	systemd? ( >=sys-apps/systemd-232:0/2[${MULTILIB_USEDEP},static-libs(-)?] )
"
