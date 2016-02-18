# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="Utilities library used by Belledonne Communications softwares like belle-sip, mediastreamer2 and linphone."
HOMEPAGE="http://www.linphone.org/"
EGIT_REPO_URI="git://git.linphone.org/bctoolbox.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	|| ( net-libs/polarssl net-libs/mbedtls )"
RDEPEND="${DEPEND}"
