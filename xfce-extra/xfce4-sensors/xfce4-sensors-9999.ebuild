# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="lm_sensors and hddtemp panel plugin"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug hddtemp"

RDEPEND="sys-apps/lm_sensors
	hddtemp? ( app-admin/hddtemp )"
DEPEND="dev-util/intltool"

pkg_postinst() {
	xfce4_pkg_postinst

	if use hddtemp; then
		[[ -u "${ROOT}"/usr/sbin/hddtemp ]] || \
		elog "You need to run \"chmod u+s /usr/sbin/hddtemp\" to show disk temperatures."
	fi
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
