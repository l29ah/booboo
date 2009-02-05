# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

EGIT_REPO_URI="git://git.psi-im.org/psi.git"
EGIT_PROJECT="psi"
EGIT_REPO_URI_IRIS="git://git.psi-im.org/iris.git"
EGIT_PROJECT_IRIS="iris"

inherit eutils qt4 multilib git

DESCRIPTION="Qt4 Jabber client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
SRC_URI=""

IUSE="crypt dbus debug doc kernel_linux spell ssl xscreensaver jingle"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

COMMON_DEPEND="|| ( ( x11-libs/qt-gui:4 x11-libs/qt-svg:4 ) =x11-libs/qt-4.3* )
	=app-crypt/qca-2*
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )
	jingle? ( >=net-libs/ortp-0.7.1 )"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

pkg_setup() {
	if has_version "=x11-libs/qt-4.3*"; then
		QT4_BUILT_WITH_USE_CHECK="qt3support png"
		QT4_OPTIONAL_BUILT_WITH_USE_CHECK="dbus"
	else
		if ! built_with_use "x11-libs/qt-gui:4" qt3support; then
			eerror "You have to build x11-libs/qt-gui:4 with qt3support."
			die "qt3support in qt-gui disabled"
		fi
		if ( use dbus && ! built_with_use "x11-libs/qt-gui:4" dbus ); then
			eerror "You have to build x11-libs/qt-gui:4 with dbus"
			die "dbus in qt-gui disabled"
		fi
	fi
	qt4_pkg_setup
}

src_unpack() {
	git_src_unpack

	# I know this is ugly, but git.eclass isn't flexible enough to do better,
	# and it doesn't support git submodule :-( )
	S_old=${S}
	S=${S}/iris
	EGIT_REPO_URI=${EGIT_REPO_URI_IRIS}
	EGIT_PROJECT=${EGIT_PROJECT_IRIS}
	git_src_unpack
	S=${S_old}
}

src_compile() {
	# disable growl as it is a MacOS X extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca"
	use debug && myconf="${myconf} --enable-debug"
	use jingle && myconf="${myconf} --enable-jingle"
	use dbus || myconf="${myconf} --disable-qdbus"
	use kernel_linux || myconf="${myconf} --disable-dnotify"
	use spell || myconf="${myconf} --disable-aspell"
	use xscreensaver || myconf="${myconf} --disable-xss"

	# cannot use econf because of non-standard configure script
	use jingle || ./configure ${myconf} || die "configure failed"
	use jingle && ./configure-jingle ${myconf} || die "configure failed"

	eqmake4 ${PN}.pro

	SUBLIBS="-L/usr/${get_libdir}/qca2" emake || die "emake failed"

	if use doc; then
		cd doc
		make api_public || die "make api_public failed"
	fi
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	# this way the docs will be installed in the standard gentoo dir
	newdoc iconsets/roster/README README.roster
	newdoc iconsets/system/README README.system
	newdoc certs/README README.certs
	dodoc README

	if use doc; then
		cd doc
		dohtml -r api || die "dohtml failed"
	fi
}
