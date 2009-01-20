# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# This is very stupid ebuild, if you want to write a good one, consider googling
# out ion3-20080207.ebuild

inherit eutils flag-o-matic

MY_PV=${PV/_p/-}
MY_PN=ion-3-${MY_PV}

DESCRIPTION="A tiling tabbed window manager designed with keyboard users in mind"
HOMEPAGE="http://www.iki.fi/tuomov/ion/"
SRC_URI="http://iki.fi/tuomov/dl/${MY_PN}.tar.gz"

LICENSE="LGPL-2.1+tuomov"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="unicode doc"
DEPEND="
	|| (
		(
			x11-libs/libICE
			x11-libs/libXext
			x11-libs/libSM
		)
		virtual/x11
	)
	dev-util/pkgconfig
	app-misc/run-mailcap
	>=dev-lang/lua-5.1.1"

S=${WORKDIR}/${MY_PN}

SCRIPTS_DIRS="keybindings scripts statusbar statusd styles"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Fix paths
	sed -ie "s/\(LUA_DIR=\).*/\1\/usr/" system.mk

	# Allow user CFLAGS
	sed -i "s:\(CFLAGS=\)-g -Os\(.*\):\1\2 ${CFLAGS}:" system.mk

	# Allow user LDFLAGS
	sed -i "s:\(LDFLAGS=\)-g -Os\(.*\):\1\2 ${LDFLAGS}:" system.mk

	# XOPEN_SOURCE does give _POSIX_MONOTONIC_CLOCK, but not CLOCK_MONOTONIC,
	# thus compile will fail
	sed -e '/CFLAGS +=.*XOPEN_SOURCE.*C99_SOURCE/s:$: $\(POSIX_SOURCE\):' \
	    -i libmainloop/Makefile

	# Rewrite install directories to be prefixed by DESTDIR for sake of portage's sandbox
	sed -i 's!\($(INSTALL\w*)\|rm -f\|ln -s\)\(.*\)\($(\w\+DIR[_]*)\)!\1\2$(DESTDIR)\3!g' Makefile */Makefile */*/Makefile build/rules.mk


	# Hey guys! Implicit rules apply to include statements also. Be more careful!
	# Fix an implicit rule that will kill the installation by rewriting a .mk
	# should configure be given just the right set of options.
	sed -i 's!%: %.in!ion-completeman: %: %.in!g' utils/Makefile

	# Fix prestripping of files
	sed -i mod_statusbar/ion-statusd/Makefile utils/ion-completefile/Makefile \
		-e 's: -s::'

	# FIX for modules
	cd ${WORKDIR}
	ln -s ${MY_PN} ion-3
}

src_compile() {
	local myconf=""

	# Methinks it's obsolete
	## xfree 
	#if has_version '>=x11-base/xfree-4.3.0'; then
	#	sed -i -e "s:DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND:#DEFINES += -DCF_XFREE86_TEXTPROP_BUG_WORKAROUND:" ${S}/system.mk
	#fi

	# help out this arch as it can't handle certain shared library linkage
	use hppa && sed -i -e "s:#PRELOAD_MODULES=1:PRELOAD_MODULES=1:" ${S}/system.mk

	# unicode support
	use unicode && sed -i -e "s:#DEFINES += -DCF_DE_USE_XUTF8:DEFINES += -DCF_DE_USE_XUTF8:" ${S}/system.mk

	cd ${S}
	make \
		LIBDIR=/usr/$(get_libdir) \
		DOCDIR=/usr/share/doc/${PF} || die

	for i in ${MODULES}
	do
		cd ${WORKDIR}/${i}

		make \
			LIBDIR=/usr/$(get_libdir)
	done
}

src_install() {

	emake \
		DESTDIR=${D} \
		DOCDIR=/usr/share/doc/${PF} \
		LIBDIR=/usr/$(get_libdir) \
	install || die

	echo -e "#!/bin/sh\n/usr/bin/ion3" > ${T}/ion3
	echo -e "#!/bin/sh\n/usr/bin/pwm3" > ${T}/pwm3
	exeinto /etc/X11/Sessions
	doexe ${T}/ion3 ${T}/pwm3

	insinto /usr/share/xsessions

	insinto /usr/share/ion3


	sed -i -e '/dopath("mod_sp")/a\dopath("mod_xrandr")' ${D}/etc/X11/ion3/cfg_defaults.lua
}

pkg_postinst() {
	elog "This is the final, stable version of ion3. Enjoy."
}
