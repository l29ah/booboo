# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_panel_plugin

DESCRIPTION="Music Player Daemon (mpd) panel plugin"
KEYWORDS="~amd64 ~x86"
IUSE="debug libmpd"

RDEPEND="libmpd? ( >=media-libs/libmpd-0.15 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-perl/XML-Parser"

pkg_config() {
	XFCE_CONFIG+=" $(use_enable libmpd)"
}

DOCS="AUTHORS ChangeLog NEWS README TODO"
