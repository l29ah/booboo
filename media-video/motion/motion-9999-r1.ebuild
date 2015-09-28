# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/motion/motion-3.2.12.ebuild,v 1.1 2011/05/19 18:50:35 ssuominen Exp $

EAPI=4
inherit eutils user git-r3 autotools

DESCRIPTION="A fork of the software motion detector"
HOMEPAGE="https://github.com/Mr-Dave/motion"
EGIT_REPO_URI="https://github.com/Mr-Dave/motion"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="ffmpeg mysql postgres v4l"

RDEPEND="sys-libs/zlib
	virtual/jpeg
	ffmpeg? ( virtual/ffmpeg )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )"
DEPEND="${RDEPEND}
	v4l? ( virtual/os-headers )"

pkg_setup() {
	enewuser motion -1 -1 -1 video
}

src_prepare() {
	eautoreconf
}

src_configure() {
	econf \
		$(use_with v4l) \
		$(use_with ffmpeg) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		--without-optimizecpu \
		${hack}
}

src_install() {
	emake \
		DESTDIR="${D}" \
		DOC='CHANGELOG CODE_STANDARD CREDITS FAQ README' \
		docdir=/usr/share/doc/${PF} \
		EXAMPLES='thread*.conf' \
		examplesdir=/usr/share/doc/${PF}/examples \
		install

	dohtml *.html

	newinitd "${FILESDIR}"/motion.initd motion
	newconfd "${FILESDIR}"/motion.confd motion
}

pkg_postinst() {
	elog "You need to setup /etc/motion.conf before running"
	elog "motion for the first time."
	elog "You can install motion detection as a service, use:"
	elog "rc-update add motion default"
}
