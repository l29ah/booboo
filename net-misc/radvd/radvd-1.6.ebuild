# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/radvd/radvd-1.5.ebuild,v 1.1 2009/11/16 09:15:46 wschlich Exp $

EAPI=2
inherit eutils

DESCRIPTION="Linux IPv6 Router Advertisement Daemon"
HOMEPAGE="http://v6web.litech.org/radvd/"
SRC_URI="http://v6web.litech.org/radvd/dist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="kernel_FreeBSD"

DEPEND="sys-devel/bison
	sys-devel/flex"
RDEPEND=""

pkg_setup() {
	enewgroup radvd
	enewuser radvd -1 -1 /dev/null radvd

	# force ownership of radvd user and group (bug #19647)
	[[ -d ${ROOT}/var/run/radvd ]] && chown radvd:radvd "${ROOT}"/var/run/radvd
}

src_configure() {
	econf \
		--with-pidfile=/var/run/radvd/radvd.pid \
		|| die "econf failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc CHANGES README TODO radvd.conf.example
	dohtml INTRO.html

	newinitd "${FILESDIR}/${PN}".init "${PN}"
	newconfd "${FILESDIR}/${PN}".conf "${PN}"

	# location of radvd.pid needs to be writeable by the radvd user
	keepdir /var/run/radvd
	chown -R radvd:radvd "${D}"/var/run/radvd
	fperms 755 /var/run/radvd

	if use kernel_FreeBSD ; then
		sed -i -e \
			's/^SYSCTL_FORWARD=.*$/SYSCTL_FORWARD=net.inet6.ip6.forwarding/g' \
			"${D}"/etc/init.d/"${PN}" || die
	fi
}

pkg_postinst() {
	einfo
	einfo "To use ${PN} you must create the configuration file"
	einfo "${ROOT}/etc/radvd.conf"
	einfo
	einfo "An example configuration file has been installed under"
	einfo "${ROOT}/usr/share/doc/${PF}"
	einfo
	einfo "grsecurity users should allow a specific group to read /proc"
	einfo "and add the radvd user to that group, otherwise radvd may"
	einfo "segfault on startup."
}
