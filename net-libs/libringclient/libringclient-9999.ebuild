# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Ring is a Voice-over-IP software phone."
HOMEPAGE="https://ring.cx/"
EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-lrc"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-qt/qtcore:5
	net-voip/ring-daemon"
RDEPEND="${DEPEND}"
