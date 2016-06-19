# Copyright 1999-2013 Gentoo Foundation
# Copyright 2014 Julian Ospald <hasufell@posteo.de>
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools eutils multilib pax-utils versionator

DESCRIPTION="Video softphone based on the SIP protocol"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.gnu.org/releases/linphone/stable/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
# TODO: run-time test for ipv6: does it need mediastreamer[ipv6]?
IUSE="assistant doc gsm-nonstandard gtk ipv6 ldap libnotify ncurses nls sqlite upnp video +zlib"

RDEPEND="
	dev-libs/libxml2
	dev-libs/openssl:0
	>=media-libs/mediastreamer-2.12.1[video?,upnp?]
	>=net-libs/belle-sip-1.4.2
	>=net-libs/libeXosip-4.0.0
	>=net-libs/libosip-4.0.0
	>=net-libs/ortp-0.24.1
	virtual/libudev
	gtk? (
		dev-libs/glib:2
		>=gnome-base/libglade-2.4.0:2.0
		>=x11-libs/gtk+-2.4.0:2
		assistant? ( >=net-libs/libsoup-2.26 )
		libnotify? ( x11-libs/libnotify )
	)
	gsm-nonstandard? ( >=media-libs/mediastreamer-2.8.2[gsm] )
	ldap? (
		dev-libs/cyrus-sasl
		net-nds/openldap
	)
	ncurses? (
		sys-libs/readline
		sys-libs/ncurses
	)
	sqlite? ( dev-db/sqlite:3 )
	upnp? ( net-libs/libupnp )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-text/sgmltools-lite )
	nls? ( dev-util/intltool )"

IUSE_LINGUAS=" fr it de he ja es pl cs nl sr sv pt_BR hu ru zh_CN"
IUSE="${IUSE}${IUSE_LINGUAS// / linguas_}"

pkg_setup() {
	if ! use gtk && ! use ncurses ; then
		ewarn "gtk and ncurses are disabled."
		ewarn "At least one of these use flags are needed to get a front-end."
		ewarn "Only liblinphone is going to be installed."
	fi

	strip-linguas ${IUSE_LINGUAS}
}

src_prepare() {
	# variable causes "command not found" warning and is not
	# needed anyway
	sed -i \
		-e 's/$(ACLOCAL_MACOS_FLAGS)//' Makefile.am || die

	# fix path to use lib64
	sed -i \
		-e "s:lib\(/liblinphone\):$(get_libdir)\1:" configure.ac \
		|| die "patching configure.ac failed"

	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_enable doc manual)
		$(use_enable doc doxygen)
		$(use_enable nls)
		--disable-static
		$(use_enable ldap)
		$(use_enable ncurses console_ui)
		$(use_enable upnp)
		$(use_enable gtk gtk_ui)
		$(use_enable libnotify notify)
		$(use_enable ipv6)
		--disable-truespeech
		$(use_enable gsm-nonstandard nonstandard-gsm)
		--disable-speex
		# seems not used, TODO: ask in ml
		$(use_enable video)
		--disable-zrtp
		$(usex gtk "$(use_enable assistant)" "--disable-assistant")
		# we don't want -Werror
		--disable-strict
		# don't bundle libs
		--enable-external-mediastreamer
		--enable-external-ortp
		$(use_enable zlib)
		--disable-dtls
		--disable-g729bCN
	)

	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" pkgdocdir="/usr/share/doc/${PF}" install # 415161
	dodoc AUTHORS BUGS ChangeLog NEWS README README.arm TODO
	pax-mark m "${ED%/}/usr/bin/linphone"
}
