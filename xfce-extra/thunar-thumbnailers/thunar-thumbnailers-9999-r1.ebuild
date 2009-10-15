# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit xfce4

xfce4_apps

DESCRIPTION="Thunar thumbnailers plugin"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-thumbnailers"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="raw ffmpeg latex grace"

RDEPEND=">=xfce-base/thunar-1.0.1
	media-gfx/imagemagick
	raw? ( media-gfx/dcraw
		media-gfx/raw-thumbnailer )
	grace? ( sci-visualization/grace )
	latex? ( virtual/latex-base )
	ffmpeg? ( media-video/ffmpegthumbnailer )"

pkg_setup() {
	XFCE_CONFIG+=" $(use_enable latex tex) $(use_enable raw) $(use_enable grace)
	$(use_enable ffmpeg) --disable-update-mime-database"
}

DOCS="AUTHORS ChangeLog NEWS README"

pkg_postinst() {
	xfce4_pkg_postinst
	elog "Run /usr/libexec/thunar-vfs-update-thumbnailers-cache-1 as a user to enable
	thumbnailers."
}
