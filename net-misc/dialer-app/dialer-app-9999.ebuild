# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit bzr cmake-utils

DESCRIPTION="Dialer app for Ubuntu Touch"
HOMEPAGE="https://launchpad.net/dialer-app"
EBZR_REPO_URI="https://code.launchpad.net/~phablet-team/dialer-app/trunk"

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	net-misc/telephony-service
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qttest:5
	dev-qt/qtdeclarative:5"
RDEPEND="${DEPEND}"
