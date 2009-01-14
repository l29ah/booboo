# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-intel/xf86-video-intel-2.5.1-r1.ebuild,v 1.2 2009/01/10 00:14:00 remi Exp $

SNAPSHOT="yes"

inherit git x-modular
EGIT_REPO_URI="git://anongit.freedesktop.org/git/xorg/driver/xf86-video-intel"

DESCRIPTION="X.Org driver for Intel cards"

KEYWORDS="~amd64 ~arm ~ia64 ~sh ~x86 ~x86-fbsd"
IUSE="dri"

RDEPEND=">=x11-base/xorg-server-1.2
	x11-libs/libXvMC"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/xextproto
	x11-proto/xineramaproto
	x11-proto/xproto
	dri? ( x11-proto/xf86driproto
			x11-proto/glproto
			>=x11-libs/libdrm-2.4.0
			x11-libs/libX11 )"

CONFIGURE_OPTIONS="$(use_enable dri)"

#PATCHES=(
#"${FILESDIR}/2.5.1-0001-clean-up-man-page-generation-and-remove-all-traces-o.patch"
#"${FILESDIR}/2.5.1-0002-include-X11-Xmd.h-to-define-CARD16-needed-by-edid.patch"
#)
