# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit git-2 eutils

DESCRIPTION="An implementation of the Infinote protocol written in GObject-based C."
HOMEPAGE="http://gobby.0x539.de/"
SRC_URI=""
EGIT_REPO_URI="git://git.0x539.de/git/infinote.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="avahi doc gtk libdaemon server static-libs"

RDEPEND="dev-libs/glib:2
	dev-libs/libxml2
	net-libs/gnutls
	>=virtual/gsasl-0.2.21
	avahi? ( net-dns/avahi )
	gtk? ( >=x11-libs/gtk+-2.12:2 )
	libdaemon? ( dev-libs/libdaemon )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.23
	dev-util/gtk-doc"

pkg_setup() {
	if use server ; then
		enewgroup infinote 100
		enewuser infinote 100 /bin/bash /var/lib/infinote infinote
	fi
}

src_prepare() {
	sh autogen.sh
}

src_configure() {
	econf \
		$(use_enable doc gtk-doc) \
		$(use_with gtk inftextgtk) \
		$(use_with gtk infgtk) \
		$(use_with server infinoted) \
		$(use_enable static-libs static) \
		$(use_with avahi) \
		$(use_with libdaemon libdaemon)
}

#src_install() {
#	emake DESTDIR="${D}" update_icon_cache=true install || die
#'Install failed'
#}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README.md TODO || die

	if use server ; then
		newinitd "${FILESDIR}/infinoted.initd" infinoted
		newconfd "${FILESDIR}/infinoted.confd" infinoted

		keepdir /var/lib/infinote
		fowners infinote:infinote /var/lib/infinote
		fperms 770 /var/lib/infinote

		dosym /usr/bin/infinoted-${MY_PV} /usr/bin/infinoted

		elog "Add local users who should have local access to the documents"
		elog "created by infinoted to the infinote group."
		elog "The documents are saved in /var/lib/infinote per default."
	fi
}

