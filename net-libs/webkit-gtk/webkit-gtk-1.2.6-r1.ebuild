# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/webkit-gtk/webkit-gtk-1.2.6.ebuild,v 1.9 2011/01/23 14:42:06 armin76 Exp $

EAPI="3"

inherit autotools flag-o-matic eutils virtualx

MY_P="webkit-${PV}"
DESCRIPTION="Open source web browser engine"
HOMEPAGE="http://www.webkitgtk.org/"
SRC_URI="http://www.webkitgtk.org/releases/${MY_P}.tar.gz"

LICENSE="LGPL-2 LGPL-2.1 BSD"
SLOT="2"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~x86-macos"
# geoclue is missing
IUSE="aqua coverage debug doc +gstreamer introspection +jit test"

# use sqlite, svg by default
# dependency on >=x11-libs/gtk+-2.13 for gail
# XXX: Quartz patch does not apply
RDEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
	virtual/jpeg
	>=media-libs/libpng-1.4
	x11-libs/cairo
	>=x11-libs/gtk+-2.13:2[aqua=]
	>=dev-libs/glib-2.21.3:2
	>=dev-libs/icu-3.8.1-r1
	>=net-libs/libsoup-2.29.90:2.4
	>=dev-db/sqlite-3
	>=app-text/enchant-0.22
	>=x11-libs/pango-1.12

	gstreamer? (
		media-libs/gstreamer:0.10
		>=media-libs/gst-plugins-base-0.10.25:0.10 )
	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )"

DEPEND="${RDEPEND}
	>=sys-devel/flex-2.5.33
	sys-devel/gettext
	dev-util/gperf
	dev-util/pkgconfig
	dev-util/gtk-doc-am
	doc? ( >=dev-util/gtk-doc-1.10 )
	test? ( x11-themes/hicolor-icon-theme )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "$FILESDIR/$PN-1.2.4-fix-widget-colors.patch"
	# FIXME: Fix unaligned accesses on ARM, IA64 and SPARC
	# https://bugs.webkit.org/show_bug.cgi?id=19775
	use sparc && epatch "${FILESDIR}"/${PN}-1.2.3-fix-pool-sparc.patch

	# intermediate MacPorts hack while upstream bug is not fixed properly
	# https://bugs.webkit.org/show_bug.cgi?id=28727
	use aqua && epatch "${FILESDIR}"/${PN}-1.2.5-darwin-quartz.patch

	# Fix build on Darwin8 (10.4 Tiger)
	epatch "${FILESDIR}"/${PN}-1.2.5-darwin8.patch

	# Don't force -O2
	sed -i 's/-O2//g' "${S}"/configure.ac || die "sed failed"

	# Don't build tests if not needed, part of bug #343249
	epatch "${FILESDIR}/${PN}-1.2.5-tests-build.patch"

	# Prevent maintainer mode from being triggered during make
	AT_M4DIR=autotools eautoreconf
}

src_configure() {
	# It doesn't compile on alpha without this in LDFLAGS
	use alpha && append-ldflags "-Wl,--no-relax"

	# Sigbuses on SPARC with mcpu and co.
	use sparc && filter-flags "-mcpu=*" "-mvis" "-mtune=*"

	# https://bugs.webkit.org/show_bug.cgi?id=42070 , #301634
	use ppc64 && append-flags "-mminimal-toc"

	local myconf

	myconf="
		--disable-introspection
		--disable-web_sockets
		$(use_enable coverage)
		$(use_enable debug)
		$(use_enable gstreamer video)
		$(use_enable introspection)
		$(use_enable jit)
		$(use aqua && echo "--with-font-backend=pango --with-target=quartz")"
		# Disable web-sockets per bug #326547

	econf ${myconf}
}

src_compile() {
	# Fix sandbox error with USE="introspection"
	# https://bugs.webkit.org/show_bug.cgi?id=35471
	emake XDG_DATA_HOME="${T}/.local" || die "Compile failed"
}

src_test() {
	unset DISPLAY
	# Tests need virtualx, bug #294691, bug #310695
	# Set XDG_DATA_HOME for introspection tools, bug #323669
	Xemake check XDG_DATA_HOME="${T}/.local" || die "Test phase failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc WebKit/gtk/{NEWS,ChangeLog} || die "dodoc failed"
}
