# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/opentracker/opentracker-9999.ebuild,v 0.1 2009/03/24 11:13:02 droz_raph Exp $

inherit cvs

ECVS_USER="anoncvs"
ECVS_SERVER="cvs.erdgeist.org:/home/cvsroot"
ECVS_MODULE="opentracker"

DESCRIPTION="An open and free bittorrent tracker"
HOMEPAGE="http://erdgeist.org/arts/software/opentracker/"

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ipv6 blacklist whitelist debug gzip restrict-stats live-sync log-network"

RDEPEND=""
DEPEND="dev-libs/dietlibc
	>=dev-libs/libowfat-0.27"

S=${WORKDIR}/${ECVS_MODULE}

src_compile() {
	# fix use of FEATURES, so it's not mixed up with portage's FEATURES
	sed -i \
	-e "s|FEATURES|FEATURES_INTERNAL|g" \
	-e "s|PREFIX?=..|PREFIX?=/usr|g" \
	-e "s|LIBOWFAT_HEADERS=\$(PREFIX)/libowfat|LIBOWFAT_HEADERS=\$(PREFIX)/include/libowfat|g" \
	-e "s|-pthread|-lpthread|g" \
	-e "s|CC?=gcc|CC=diet gcc|g" \
	-e "s|BINDIR?=\$(PREFIX)/bin|BINDIR?=\$(DESTDIR)\$(PREFIX)/bin|g" \
	Makefile
	use ipv6 && sed -i '/WANT_V6/s/^#*//' Makefile
	use blacklist && use whitelist && die "USE blacklist and whitelist are exclusive"
	use blacklist && sed -i '/DWANT_ACCESSLIST_BLACK/s/^#*//' Makefile
	use whitelist && sed -i '/DWANT_ACCESSLIST_WHITE/s/^#*//' Makefile
	use gzip && sed -i '/DWANT_COMPRESSION_GZIP/s/^#*//' Makefile
	use restrict-stats && sed -i '/DWANT_RESTRICT_STATS/s/^#*//' Makefile
	use live-sync && sed -i '/DWANT_SYNC_LIVE/s/^#*//' Makefile
	use log-network && sed -i '/DWANT_LOG_NETWORKS/s/^#*//' Makefile

	if use debug; then
		sed -i '/D_DEBUG_HTTPERROR/s/^#*//' Makefile
		sed -i '$a\\tinstall -m 755 opentracker.debug $(BINDIR)' Makefile
		! [[ "${FEATURES}" =~ nostrip ]] && \
		ewarn "Please emerge with FEATURES=nostrip to get debug really effective" && \
		sleep 2
	fi

	if use debug; then
		emake all || die "emake failed"
	else
		emake opentracker || die "emake failed"
	fi
}

src_install() {
	mkdir -p ${D}usr/bin
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc README README_v6 opentracker.conf.sample
}

