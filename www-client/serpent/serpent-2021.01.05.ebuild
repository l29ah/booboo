# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
WANT_AUTOCONF="2.1"
MOZ_ESR=""

MOZCONFIG_OPTIONAL_GTK2ONLY=1
MOZCONFIG_OPTIONAL_WIFI=0

inherit check-reqs flag-o-matic toolchain-funcs eutils gnome2-utils mozconfig-v6.52 pax-utils xdg-utils autotools

	UXP_VER="RELBASE_20201218"
	BAS_VER="${PV}"
	SRC_URI="
		https://repo.palemoon.org/MoonchildProductions/UXP/archive/$UXP_VER.tar.gz -> UXP-$UXP_VER.tar.gz
		https://repo.palemoon.org/MoonchildProductions/Basilisk/archive/v$BAS_VER.tar.gz -> basilisk-$BAS_VER.tar.gz
	"
	S="${WORKDIR}/basilisk"

DESCRIPTION="A XUL-based web-browser demonstrating the Unified XUL Platform (UXP)."
HOMEPAGE="http://www.basilisk-browser.org/"

KEYWORDS="~amd64 ~ppc64"

SLOT="0"
LICENSE="MPL-2.0 GPL-2 LGPL-2.1"
IUSE="gconf +eme-free hardened +privacy hwaccel jack pulseaudio selinux test -system-zlib -system-bz2 -system-hunspell -system-ffi -system-pixman -system-jpeg -system-libevent +webrtc"
RESTRICT="mirror"

ASM_DEPEND=">=dev-lang/yasm-1.1"

RDEPEND="
	dev-util/pkgconfig
	gconf? ( gnome-base/gconf )
	jack? ( virtual/jack )
	system-zlib? ( sys-libs/zlib )
	system-bz2? ( app-arch/bzip2 )
	system-hunspell? ( app-text/hunspell )
	system-ffi? ( dev-libs/libffi )
	system-pixman? ( x11-libs/pixman )
	system-jpeg? ( media-libs/libjpeg-turbo )
	system-libevent? ( dev-libs/libevent )
	selinux? ( sec-policy/selinux-mozilla )"

DEPEND="${RDEPEND}
	amd64? ( ${ASM_DEPEND} virtual/opengl )
	x86? ( ${ASM_DEPEND} virtual/opengl )"

QA_PRESTRIPPED="usr/lib*/${PN}/serpent"

BUILD_OBJ_DIR="${S}/ff"

src_unpack() {
	unpack basilisk-$BAS_VER.tar.gz || die
	unpack UXP-$UXP_VER.tar.gz || die "Failed to unpack application source"
	cd "${S}" && rm -rf platform && mv ../uxp ./platform || die "Failed to unpack application source"
}

pkg_setup() {
	moz_pkgsetup

	# Clean garbage
	unset DBUS_SESSION_BUS_ADDRESS \
		DISPLAY \
		ORBIT_SOCKETDIR \
		SESSION_MANAGER \
		XDG_SESSION_COOKIE \
		XAUTHORITY
}

pkg_pretend() {
	# Ensure we have enough disk space to compile
	CHECKREQS_DISK_BUILD="4G"
	check-reqs_pkg_setup
}

src_prepare() {
	# Apply our application specific patches to UXP source tree
	eapply "${FILESDIR}"/0001-gcc-hardened-workaround.patch

	# Allow user to apply any additional patches without modifing ebuild
	eapply_user
}

src_configure() {
	MEXTENSIONS="default"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	# Add full relro support for hardened
	use hardened && append-ldflags "-Wl,-z,relro,-z,now"

	mozconfig_annotate '' --enable-extensions="${MEXTENSIONS}"

	echo "mk_add_options MOZ_OBJDIR=${BUILD_OBJ_DIR}" >> "${S}"/.mozconfig
	echo "mk_add_options XARGS=/usr/bin/xargs" >> "${S}"/.mozconfig

	if use gconf ; then
		echo "ac_add_options --enable-gconf" >> "${S}"/.mozconfig
	else
		echo "ac_add_options --disable-gconf" >> "${S}"/.mozconfig
	fi

	if use jack ; then
		echo "ac_add_options --enable-jack" >> "${S}"/.mozconfig
	fi

	if use pulseaudio ; then
		echo "ac_add_options --enable-pulseaudio" >> "${S}"/.mozconfig
	else
		echo "ac_add_options --disable-pulseaudio" >> "${S}"/.mozconfig
	fi

	if use system-zlib ; then
		echo "ac_add_options --with-system-zlib" >> "${S}"/.mozconfig
	fi

	if use system-bz2 ; then
		echo "ac_add_options --with-system-bz2" >> "${S}"/.mozconfig
	fi

	if use system-hunspell ; then
		echo "ac_add_options --enable-system-hunspell" >> "${S}"/.mozconfig
	fi

	if use system-ffi ; then
		echo "ac_add_options --enable-system-ffi" >> "${S}"/.mozconfig
	fi

	if use system-pixman ; then
		echo "ac_add_options --enable-system-pixman" >> "${S}"/.mozconfig
	fi

	if use system-jpeg ; then
		echo "ac_add_options --with-system-jpeg" >> "${S}"/.mozconfig
	fi

	if use system-libevent ; then
		echo "ac_add_options --with-system-libevent" >> "${S}"/.mozconfig
	fi

	if use eme-free; then
		echo "ac_add_options --disable-eme" >> "${S}"/.mozconfig
	else
		echo "ac_add_options --enable-eme" >> "${S}"/.mozconfig
	fi

	# Disable unneeded stuff
	echo "ac_add_options --disable-updater" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-crashreporter" >> "${S}"/.mozconfig

	# Favor Privacy over features at compile time
	if use privacy; then
		echo "ac_add_options --disable-userinfo" >> "${S}"/.mozconfig
		echo "ac_add_options --disable-safe-browsing" >> "${S}"/.mozconfig
		echo "ac_add_options --disable-url-classifier" >> "${S}"/.mozconfig
		echo "ac_add_options --disable-mozril-geoloc" >> "${S}"/.mozconfig
		echo "ac_add_options --disable-nfc" >> "${S}"/.mozconfig
	else
		echo "ac_add_options --enable-mozril-geoloc" >> "${S}"/.mozconfig
		echo "ac_add_options --enable-nfc" >> "${S}"/.mozconfig
	fi

	if use webrtc; then
		echo "ac_add_options --enable-webrtc" >> "${S}"/.mozconfig
	else
		echo "ac_add_options --disable-webrtc" >> "${S}"/.mozconfig
	fi

	# TODO: separate some of these into their own use flags
	echo "ac_add_options --disable-synth-pico" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-b2g-camera" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-b2g-ril" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-b2g-bt" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-gamepad" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-tests" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-maintenance-service" >> "${S}"/.mozconfig

	#Build Serpent
	echo "ac_add_options --enable-application=basilisk" >> "${S}"/.mozconfig
	echo "ac_add_options --disable-official-branding" >> "${S}"/.mozconfig
	echo "ac_add_options --prefix='${EPREFIX}/usr'" >> "${S}"/.mozconfig
	echo "export MOZILLA_OFFICIAL=0"
	echo "export MOZ_TELEMETRY_REPORTING=0"
	echo "export MOZ_ADDON_SIGNING=1"
	echo "export MOZ_REQUIRE_SIGNING=0"

	# workaround for funky/broken upstream configure...
	SHELL="${SHELL:-${EPREFIX%/}/bin/bash}" \
	./mach configure || die "Failed to configure"
}

src_compile() {
	MOZ_MAKE_FLAGS="${MAKEOPTS}" SHELL="${SHELL:-${EPREFIX%/}/bin/bash}" \
	./mach build || die "Failed to build"
}

src_install() {
	cd "${BUILD_OBJ_DIR}" || die

	# Pax mark xpcshell for hardened support, only used for startupcache creation.
	pax-mark m "${BUILD_OBJ_DIR}"/dist/bin/xpcshell

	cd "${S}" || die
	MOZ_MAKE_FLAGS="${MAKEOPTS}" SHELL="${SHELL:-${EPREFIX%/}/bin/bash}" \
	DESTDIR="${D}" ./mach install || die "Failed to install"

	# Rename everything from basilisk to serpent so we can co-install with branded Basilisk
	mv "${D}/usr/lib/basilisk-52.9.0" "${D}/usr/lib/serpent-52.9.0" || die
	mv "${D}/usr/lib/serpent-52.9.0/basilisk" "${D}/usr/lib/serpent-52.9.0/serpent" || die
	mv "${D}/usr/lib/serpent-52.9.0/basilisk-bin" "${D}/usr/lib/serpent-52.9.0/serpent-bin" || die
	mv "${D}/usr/lib/basilisk-devel-52.9.0"  "${D}/usr/lib/serpent-devel-52.9.0" || die
	mv "${D}/usr/include/basilisk-52.9.0" "${D}/usr/include/serpent-52.9.0" || die
	mv "${D}/usr/share/idl/basilisk-52.9.0" "${D}/usr/share/idl/serpent-52.9.0" || die
	rm "${D}/usr/bin/basilisk" || die
	ln -s "/usr/lib/serpent-52.9.0/serpent" "${D}/usr/bin/serpent" || die
	rm "${D}/usr/lib/serpent-devel-52.9.0/bin" || die
	rm "${D}/usr/lib/serpent-devel-52.9.0/idl" || die
	rm "${D}/usr/lib/serpent-devel-52.9.0/include" || die
	rm "${D}/usr/lib/serpent-devel-52.9.0/lib" || die
	ln -s "/usr/lib/serpent-52.9.0" "${D}/usr/lib/serpent-devel-52.9.0/bin" || die
	ln -s "/usr/share/idl/serpent-52.9.0" "${D}/usr/lib/serpent-devel-52.9.0/idl" || die
	ln -s "/usr/include/serpent-52.9.0" "${D}/usr/lib/serpent-devel-52.9.0/include" || die
	ln -s "/usr/lib/serpent-devel-52.9.0/sdk/lib" "${D}/usr/lib/serpent-devel-52.9.0/lib" || die

	# Install language packs
	# mozlinguas_src_install

	local size sizes icon_path icon name
		sizes="16 32 48"
		icon_path="${S}/basilisk/branding/unofficial"
		icon="serpent"
		name="Serpent Browser"

	# Install icons and .desktop for menu entry
	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png"
	done
	# The 128x128 icon has a different name
	insinto "/usr/share/icons/hicolor/128x128/apps"
	newins "${icon_path}/mozicon128.png" "${icon}.png"
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${icon_path}/content/icon48.png" "${icon}.png"
	newmenu "${FILESDIR}/icon/${PN}.desktop" "${PN}.desktop"
	sed -i -e "s:@NAME@:${name}:" -e "s:@ICON@:${icon}:" \
		"${ED}/usr/share/applications/${PN}.desktop" || die

	# Add StartupNotify=true bug 237317
	if use startup-notification ; then
		echo "StartupNotify=true"\
			 >> "${ED}/usr/share/applications/${PN}.desktop" \
			|| die
	fi

	# Required in order to use plugins and even run firefox on hardened.
	pax-mark m "${ED}"${MOZILLA_FIVE_HOME}/{serpent,serpent-bin,plugin-container}

}

pkg_preinst() {
	gnome2_icon_savelist

	# if the apulse libs are available in MOZILLA_FIVE_HOME then apulse
	# doesn't need to be forced into the LD_LIBRARY_PATH
	if use pulseaudio && has_version ">=media-sound/apulse-0.1.9" ; then
		einfo "APULSE found - Generating library symlinks for sound support"
		local lib
		pushd "${ED}"${MOZILLA_FIVE_HOME} &>/dev/null || die
		for lib in ../apulse/libpulse{.so{,.0},-simple.so{,.0}} ; do
			# a quickpkg rolled by hand will grab symlinks as part of the package,
			# so we need to avoid creating them if they already exist.
			if ! [ -L ${lib##*/} ]; then
				ln -s "${lib}" ${lib##*/} || die
			fi
		done
		popd &>/dev/null || die
	fi
}

pkg_postinst() {
	# Update mimedb for the new .desktop file
	xdg_desktop_database_update
	gnome2_icon_cache_update

	if use pulseaudio && has_version ">=media-sound/apulse-0.1.9" ; then
		elog "Apulse was detected at merge time on this system and so it will always be"
		elog "used for sound.  If you wish to use pulseaudio instead please unmerge"
		elog "media-sound/apulse."
	fi
}

pkg_postrm() {
	gnome2_icon_cache_update
}
