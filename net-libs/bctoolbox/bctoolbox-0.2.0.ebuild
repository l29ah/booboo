# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="Utilities library used by Belledonne Communications softwares like belle-sip, mediastreamer2 and linphone."
HOMEPAGE="http://www.linphone.org/"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="git://git.linphone.org/bctoolbox.git"
else
	SRC_URI="https://www.linphone.org/releases/sources/bctoolbox/$P.tar.gz"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND="
	|| ( net-libs/polarssl net-libs/mbedtls )"
DEPEND="${RDEPEND}
	dev-util/cunit"
