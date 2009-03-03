# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit xfce4

xfce4_goodies

DESCRIPTION="Thunar volume management"
HOMEPAGE="http://foo-projects.org/~benny/projects/thunar-volman"

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug"

RDEPEND="dev-libs/dbus-glib
	sys-apps/hal
	>=xfce-extra/exo-0.3.8[hal]
	>=xfce-base/thunar-${THUNAR_VERSION}"

DOCS="AUTHORS ChangeLog NEWS README THANKS"
