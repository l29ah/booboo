# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )
inherit distutils-r1 versionator

DESCRIPTION="A command-line Last.fm scrobbler and a now-playing status updater."
HOMEPAGE="https://pypi.python.org/pypi/scrobblerh/"
MY_PN=scrobblerh
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/$MY_PN-$PV.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/lfmh[$PYTHON_USEDEP]
	dev-python/docopt[$PYTHON_USEDEP]
	dev-python/appdirs[$PYTHON_USEDEP]"
RDEPEND="${DEPEND}"

S="$WORKDIR/$MY_PN-$PV"
