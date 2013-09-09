# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/fbreader/fbreader-0.99.1.ebuild,v 1.1 2012/09/04 11:18:36 alexxy Exp $

EAPI=4

inherit eutils multilib

DESCRIPTION="E-Book Reader. Supports many e-book formats."
HOMEPAGE="http://www.fbreader.org/"
SRC_URI="http://www.fbreader.org/files/desktop/${PN}-sources-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="debug"
DEPEND="dev-libs/expat
	dev-libs/liblinebreak
	net-misc/curl
	dev-libs/fribidi
	app-arch/bzip2
	dev-db/sqlite
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	"
RDEPEND="${DEPEND}"

src_prepare() {
	# Still use linebreak instead of new unibreak
	sed -e "s:-lunibreak:-llinebreak:" \
		-i makefiles/config.mk zlibrary/text/Makefile || die "fixing libunibreak failed"
# Let portage decide about the compiler
	sed -e "/^CC = /d" \
		-i makefiles/arch/desktop.mk || die "removing CC line failed"

	#Tidy up the .desktop file
	sed -e "s:^Name=E-book reader:Name=FBReader:" \
		-e "s:^Name\[ru\]=.*$:Name\[ru\]=FBReader:" \
		-e "s:^Icon=FBReader.png:Icon=FBReader:" \
		-i fbreader/desktop/desktop || die "tidying desktop failed"
	sed -e "/^	LDFLAGS += -s$/ d" \
		-i makefiles/config.mk || die "sed failed"
	sed -e "/^LDFLAGS =$/ d" \
		-i makefiles/arch/desktop.mk || die "sed failed"

	echo "TARGET_ARCH = desktop" > makefiles/target.mk
	echo "LIBDIR = /usr/$(get_libdir)" >> makefiles/target.mk

	# qt4
	echo "UI_TYPE = qt4" >> makefiles/target.mk
	sed -e 's:CFLAGS =:CFLAGS = $(shell pkg-config --cflags glib-2.0):' \
		-e 's:UILIBS = -lQtCore:UILIBS = $(shell pkg-config --libs QtCore) -lQtCore:' \
		-e 's:MOC = moc-qt4:MOC = /usr/bin/moc:' \
		-i makefiles/arch/desktop.mk || die "updating desktop.mk failed"

	if use debug; then
		echo "TARGET_STATUS = debug" >> makefiles/target.mk
	else
		echo "TARGET_STATUS = release" >> makefiles/target.mk
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dosym /usr/bin/FBReader /usr/bin/fbreader
}
