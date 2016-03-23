# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit  cmake-utils

DESCRIPTION="Vista file IO library"
HOMEPAGE="http://mia.sf.net/"
SRC_URI="mirror://sourceforge/mia/vistaio-${PV}.tar.xz"
RESTRICT="primaryuri"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPENDS="app-arch/xz-utils"
