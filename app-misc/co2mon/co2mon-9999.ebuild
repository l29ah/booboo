# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="CLI for MasterKit CO2 Monitor"
HOMEPAGE="https://github.com/dmage/co2mon"
EGIT_REPO_URI="https://github.com/dmage/co2mon"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+rrdtool"

DEPEND="
	rrdtool? ( net-analyzer/rrdtool )
	dev-libs/hidapi"
RDEPEND="${DEPEND}"

src_install() {
	dolib $BUILD_DIR/libco2mon/libco2mon.*
	doheader libco2mon/include/co2mon.h
	dobin $BUILD_DIR/co2mond/co2mond
	if use rrdtool; then
		keepdir /var/db/co2mon/
		dobin "$FILESDIR/co2mond-rrd"
		doinitd "$FILESDIR/init.d/co2mond-rrd"
	fi
}
