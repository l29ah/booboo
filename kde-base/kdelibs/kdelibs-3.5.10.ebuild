# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.5.10.ebuild,v 1.2 2008/09/14 02:27:06 mr_bones_ Exp $

EAPI="1"
inherit kde flag-o-matic eutils multilib
set-kdedir 3.5

DESCRIPTION="KDE libraries needed by all KDE programs."
HOMEPAGE="http://www.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/${P}.tar.bz2
	mirror://gentoo/kdelibs-3.5-patchset-15.tar.bz2
	mirror://gentoo/kde-3.5.9-seli-xinerama.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.5"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="acl alsa arts bindist branding cups doc jpeg2k kerberos legacyssl utempter openexr spell tiff
	avahi kernel_linux fam lua kdehiddenvisibility"

# Added aspell-en as dependency to work around bug 131512.
# Made openssl and zeroconf mandatory dependencies, see bug #172972 and #175984
RDEPEND="x11-libs/libXext
	arts? ( ~kde-base/arts-3.5.10 )
	app-arch/bzip2
	>=dev-libs/openssl-0.9.7d
	>=dev-libs/libxslt-1.1.16
	>=dev-libs/libxml2-2.6.6
	>=dev-libs/libpcre-6.6
	media-libs/fontconfig
	>=media-libs/freetype-2
	media-libs/libart_lgpl
	net-dns/libidn
	>=x11-libs/qt-3.3.3:3
	acl? ( kernel_linux? ( sys-apps/acl ) )
	alsa? ( media-libs/alsa-lib )
	cups? ( >=net-print/cups-1.1.19 )
	tiff? ( media-libs/tiff )
	kerberos? ( virtual/krb5 )
	jpeg2k? ( media-libs/jasper )
	openexr? ( >=media-libs/openexr-1.2.2-r2 )
	!avahi? ( !bindist? ( net-misc/mDNSResponder !kde-misc/kdnssd-avahi ) )
	fam? ( virtual/fam )
	virtual/ghostscript
	utempter? ( sys-libs/libutempter )
	!kde-base/kde-env
	lua? ( dev-lang/lua )
	spell? ( >=app-text/aspell-0.60.5 >=app-dicts/aspell-en-6.0.0 )
	>=sys-apps/portage-2.1.2.11
	!kde-base/ksync
	!kde-base/kdebindings-meta
	!=kde-base/artsplugin-mpeglib-3.5*
	!=kde-base/artsplugin-mpg123-3.5*
	!=kde-base/mpeglib-3.5*
	!kde-base/kdeaccessibility
	!kde-base/kdeaddons
	!kde-base/kdeadmin
	!kde-base/kdeartwork
	!kde-base/kdebase
	!kde-base/kdeedu
	!kde-base/kdegames
	!kde-base/kdegraphics
	!kde-base/kde
	!kde-base/kdemultimedia
	!kde-base/kdenetwork
	!kde-base/kdepim
	!kde-base/kdesdk
	!kde-base/kdetoys
	!kde-base/kdeutils
	!kde-base/kdewebdev"

DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	sys-devel/gettext"

RDEPEND="${RDEPEND}
	x11-apps/rgb
	x11-apps/iceauth"

PDEPEND="avahi? ( kde-misc/kdnssd-avahi )
	bindist? ( kde-misc/kdnssd-avahi )"

# Testing code is rather broken and merely for developer purposes, so disable it.
RESTRICT="test"

pkg_setup() {
	if use legacyssl ; then
		echo ""
		elog "You have the legacyssl use flag enabled, which fixes issues with some broken"
		elog "sites, but breaks others instead. It is strongly discouraged to use it."
		elog "For more information, see bug #128922."
		echo ""
	fi

	if ! use utempter ; then
		echo ""
		elog "On some setups, which rely on the correct update of utmp records, not using"
		elog "utempter might not update them correctly. If you experience unexpected"
		elog "behaviour, try to rebuild kde-base/kdelibs with utempter use-flag enabled."
		echo ""
	fi

	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "The alsa USE flag in this package enables ALSA support"
		eerror "for libkmid, KDE midi library."
		eerror "For this reason, you have to merge media-libs/alsa-lib"
		eerror "with the midi USE flag enabled, or disable alsa USE flag"
		eerror "for this package."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	kde_src_unpack

	if use legacyssl ; then
		# This patch won't be included upstream, see bug #128922.
		epatch "${WORKDIR}/patches/kdelibs_3.5.4-kssl-3des.patch"
	fi

	if use utempter ; then
		# Bug #135818 is the eternal reference.
		epatch "${WORKDIR}/patches/kdelibs-3.5_libutempter.patch"
	fi

	if use branding ; then
		# Add "(Gentoo)" to khtml user agent.
		epatch "${WORKDIR}/patches/kdelibs_3.5-cattlebrand.diff"
	fi

	# Xinerama patch by Lubos Lunak.
	# http://ktown.kde.org/~seli/xinerama/
	epatch "${WORKDIR}/${PN}-xinerama.patch"
}

src_compile() {
	rm -f "${S}/configure"

	myconf="--with-distribution=Gentoo --disable-fast-malloc
			--with-libart --with-libidn --with-ssl
			--without-hspell
			$(use_enable fam libfam) $(use_enable kernel_linux dnotify)
			$(use_with acl) $(use_with alsa)
			$(use_with arts) $(use_enable cups)
			$(use_with kerberos gssapi) $(use_with tiff)
			$(use_with jpeg2k jasper) $(use_with openexr)
			$(use_with utempter) $(use_with lua)
			$(use_enable kernel_linux sendfile) --enable-mitshm
			$(use_with spell aspell)"

	if use avahi || use bindist ; then
		myconf="${myconf} --disable-dnssd"
	else
		myconf="${myconf} --enable-dnssd"
	fi

	if has_version x11-apps/rgb; then
		myconf="${myconf} --with-rgbfile=/usr/share/X11/rgb.txt"
	fi

	# fix bug 58179, bug 85593
	# kdelibs-3.4.0 needed -fno-gcse; 3.4.1 needs -mminimal-toc; this needs a
	# closer look... - corsair
	use ppc64 && append-flags "-mminimal-toc"

	# work around bug #120858, gcc 3.4.x -Os miscompilation
	use x86 && replace-flags "-Os" "-O2" # see bug #120858

	replace-flags "-O3" "-O2" # see bug #148180

	kde_src_compile

	if use doc; then
		emake apidox || die
	fi
}

src_install() {
	kde_src_install

	if use doc; then
		emake DESTDIR="${D}" install-apidox || die
	fi

	# Needed to create lib -> lib64 symlink for amd64 2005.0 profile
	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${KDEDIR}/lib
	fi

	# Get rid of the disabled version of the kdnsd libraries
	if use avahi || use bindist ; then
		rm -rf "${D}/${PREFIX}"/$(get_libdir)/libkdnssd.*
	fi

	dodir /etc/env.d

	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${PREFIX}/${libdir}"
	done

	# KDE implies that the install path ist listed first in KDEDIRS and the user
	# directory (implicitly added) to be the last entry. Doing otherwise breaks
	# certain functionality. Do not break this (once again *sigh*), but read the code.
	cat <<EOF > "${D}"/etc/env.d/45kdepaths-${SLOT} # number goes down with version upgrade
PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs:1}
MANPATH=${PREFIX}/share/man
CONFIG_PROTECT="${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown /usr/share/config"
KDEDIRS="${PREFIX}:/usr:/usr/local"
#KDE_IS_PRELINKED=1
# Excessive flushing to disk as in releases before KDE 3.5.10. Usually you don't want that.
#KDE_EXTRA_FSYNC=1
XDG_DATA_DIRS="/usr/share:${PREFIX}/share:/usr/local/share"
COLON_SEPARATED="XDG_DATA_DIRS"
EOF

	# Install shell script to run KDE 3 applications from outside of the KDE 3 desktop
	# See http://lists.kde.org/?t=120569055200005&r=1&w=2 for reference

	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${PREFIX}/${_libdir}"
	done
	_libdirs=${_libdirs#:}

	# Merge KDE prefix and LDPATH
	sed -e "s#@REPLACE_PREFIX@#${PREFIX}#" \
		-e  "s#@REPLACE_LIBS@#${_libdirs}#" \
		-i "${WORKDIR}/patches/kde3" || die "sed failed"
	dobin "${WORKDIR}/patches/kde3"

	# Make sure the target for the revdep-rebuild stuff exists. Fixes bug 184441.
	dodir /etc/revdep-rebuild

cat <<EOF > "${D}"/etc/revdep-rebuild/50-kde3
SEARCH_DIRS="${PREFIX}/bin ${PREFIX}/lib*"
EOF
}
