# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 autotools

DESCRIPTION="Ring is a Voice-over-IP software phone."
HOMEPAGE="https://ring.cx/"
EGIT_REPO_URI="https://gerrit-ring.savoirfairelinux.com/ring-daemon"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	net-libs/opendht
	>=net-libs/pjsip-2.4[ring]"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}
