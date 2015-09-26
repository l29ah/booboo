# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Ring is a Voice-over-IP software phone."
HOMEPAGE="https://ring.cx/"
EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-client-gnome"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	net-libs/libringclient
	media-libs/clutter
	media-libs/clutter-gtk
	libnotify? ( x11-libs/libnotify )
	x11-themes/gnome-icon-theme-symbolic
	>=x11-libs/gtk+-3.10
	app-text/libebook
	>=gnome-extra/evolution-data-server-3.10
	"
RDEPEND="${DEPEND}"
