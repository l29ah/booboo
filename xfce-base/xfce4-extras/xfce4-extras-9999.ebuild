# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Meta ebuild for panel plugins and extra applications"
HOMEPAGE="http://www.xfce.org"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="battery cpufreq hal gnome lm_sensors wifi"

RDEPEND="~xfce-extra/xfce4-time-out-9999
	~xfce-extra/xfce4-clipman-9999
	~xfce-extra/xfce4-datetime-9999
	~xfce-extra/xfce4-dict-9999
	~xfce-extra/xfce4-mount-9999
	~xfce-extra/xfce4-notes-9999
	~xfce-extra/xfce4-quicklauncher-9999
	~xfce-extra/xfce4-screenshooter-9999
	~xfce-extra/xfce4-systemload-9999
	~xfce-extra/xfce4-weather-9999
	~xfce-extra/xfce4-xkb-9999
	~xfce-extra/xfce4-netload-9999
	~xfce-extra/xfce4-fsguard-9999
	~xfce-extra/xfce4-cpugraph-9999
	~xfce-extra/xfce4-taskmanager-9999
	~xfce-extra/xfce4-timer-9999
	~xfce-extra/xfce4-diskperf-9999
	~xfce-extra/xfce4-genmon-9999
	~xfce-extra/xfce4-smartbookmark-9999
	~xfce-extra/xfce4-mailwatch-9999
	~xfce-extra/xfce4-places-9999
	~xfce-extra/xfce4-eyes-9999
	~xfce-extra/verve-9999
	~xfce-extra/thunar-thumbnailers-9999
	~xfce-extra/thunar-archive-9999
	~xfce-extra/thunar-media-tags-9999
	hal? ( ~xfce-extra/thunar-volman-9999 )
	cpufreq? ( ~xfce-extra/xfce4-cpu-freq-9999 )
	gnome? ( ~xfce-extra/xfce4-xfapplet-9999 )
	battery? ( ~xfce-extra/xfce4-battery-9999 )
	wifi? ( ~xfce-extra/xfce4-wavelan-9999 )
	lm_sensors? ( ~xfce-extra/xfce4-sensors-9999 )"
