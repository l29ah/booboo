# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="The Tcl UDP extension provides a simple library to support UDP socket in Tcl."
HOMEPAGE="http://sourceforge.net/projects/tcludp/"
SRC_URI="https://downloads.sourceforge.net/tcludp/$PV/${P}.tar.gz"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/tcl"
RDEPEND="${DEPEND}"

S="$WORKDIR/$PN"
