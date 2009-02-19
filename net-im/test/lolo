# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-9999.ebuild,v 1.0 2008/03/24 08:52:16 Rion Exp $

inherit eutils qt4 multilib git subversion

DESCRIPTION="QT 4.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://psi-im.org/"
EAPI="2"

EGIT_REPO_URI="git://github.com/psi-im/psi.git"
EGIT_PROJECT="psi"

IUSE="crypt doc kernel_linux spell ssl xscreensaver debug jingle powersave onewindow"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"

COMMON_DEPEND=">=x11-libs/qt-core-4.4
	>=x11-libs/qt-gui-4.4
	>=x11-libs/qt-dbus-4.4
	>=x11-libs/qt-qt3support-4.4
	>=x11-libs/qt-svg-4.4
	>=app-crypt/qca-2
	spell? ( app-text/aspell )
	xscreensaver? ( x11-libs/libXScrnSaver )"

DEPEND="${COMMON_DEPEND}
	!!net-im/psi
	doc? ( app-doc/doxygen )
	sys-devel/qconf"

RDEPEND="${COMMON_DEPEND}
	crypt? ( >=app-crypt/qca-gnupg-2.0.0_beta2 )
	ssl? ( >=app-crypt/qca-ossl-2.0.0_beta2 )"

QT4_BUILT_WITH_USE_CHECK="qt3support png"

src_unpack() {
	git_src_unpack

	S="${S}/iris"
	EGIT_REPO_URI="git://github.com/psi-im/iris.git"
	EGIT_PROJECT="iris"
	git_src_unpack

	S="${WORKDIR}/patches"
	ESVN_REPO_URI=http://psi-dev.googlecode.com/svn/trunk/patches
	ESVN_PROJECT=psi_patches
	subversion_src_unpack
	rm "${WORKDIR}/patches"/010* #useless windows patch
	local rev
	rev=`svnversion "${PORTAGE_ACTUAL_DISTDIR}/svn-src/psi_patches/patches"`
	sed "s/\(dev-rXXX\)/dev-r${rev}/" -i "${WORKDIR}/patches"/280-psi-application-info.diff

	S="${WORKDIR}/${P}"
	cd "${S}"
	epatch "${WORKDIR}/patches"/*.diff

	use powersave && epatch "${WORKDIR}/patches"/psi-reduce_power_consumption.patch
	use onewindow && epatch "${WORKDIR}/patches"/psi-all_in_one_window.patch
}

src_compile() {
	cd iris
	qconf
	./configure || die "configure iris failed"
	emake -j1 || die "make iris failed"
	cd ..

	# disable growl as it is a mac osx extension only
	local myconf="--prefix=/usr --qtdir=/usr"
	myconf="${myconf} --disable-growl --disable-bundled-qca"
	use kernel_linux || myconf="${myconf} --disable-dnotify"
	use spell || myconf="${myconf} --disable-aspell"
	use xscreensaver || myconf="${myconf} --disable-xss"
	use debug && myconf="${myconf} --enable-debug"

	# cannot use econf because of non-standard configure script
	if use jingle; then
		ewarn "Jinglke is unsupported. just keep in mind"
		./configure-jingle ${myconf} --enable-jingle || die "configure-jingle failed"
	else
		./configure ${myconf} || die "configure failed"
	fi

	emake || die "emake failed"

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

