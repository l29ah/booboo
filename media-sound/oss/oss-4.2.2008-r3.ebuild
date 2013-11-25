# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

inherit eutils versionator linux-mod

MY_PV=$(get_version_component_range 1-2)
MY_BUILD=$(get_version_component_range 3)
MY_P="oss-v${MY_PV}-build${MY_BUILD}-src-gpl"

DESCRIPTION="Open Sound System - portable, mixing-capable, high quality sound system for Unix."
HOMEPAGE="http://developer.opensound.com/"
SRC_URI="
	http://www.4front-tech.com/developer/sources/stable/gpl/${MY_P}.tar.bz2
	http://opensound.com/forum/download/file.php?id=113 ->
		oss-4.2.2007-linux-3.8.patch
	http://opensound.com/forum/download/file.php?id=129 ->
		oss-4.2.2008-linux-3.10.7.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="gtk salsa midi vmix_fixedpoint"

RESTRICT="mirror"

DEPEND="sys-apps/gawk 
	gtk? ( >=x11-libs/gtk+-2 ) 
	>=sys-kernel/linux-headers-2.6.11
	!media-sound/oss-devel"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	epatch "$DISTDIR/oss-4.2.2007-linux-3.8.patch"
	epatch "$FILESDIR/oss-4.2.2008-linux-3.10.patch"
	epatch "$DISTDIR/oss-4.2.2008-linux-3.10.7.patch"
	epatch "$FILESDIR/oss-4.2.2008-linux-3.12.patch"
	mkdir "${WORKDIR}/build"

	einfo "Replacing init script with gentoo friendly one ..."
	cp "${FILESDIR}/oss" "${S}/setup/Linux/oss/etc/S89oss"

	sed -i -e 's/-Werror//' phpmake/Makefile.php setup/Linux/oss/build/install.sh setup/srcconf_linux.inc

	#epatch "${FILESDIR}/usb.patch"
}

src_configure() {
	local myconf="$(use salsa && echo  || echo --enable-libsalsa=NO) \
		--config-midi=$(use midi && echo YES || echo NO) \
		--config-vmix=$(use vmix_fixedpoint && echo FIXEDPOINT || echo FLOAT)"

	cd "${WORKDIR}/build"

	# Configure has to be run from build dir with full path.
	"${S}"/configure \
		${myconf} || die "configure failed"
}

src_compile() {
	cd "${WORKDIR}/build"

	emake build || die 'emake failed'
}
	
src_install() {
	newinitd "${FILESDIR}/oss" oss
	cp -R "${WORKDIR}"/build/prototype/* "${D}" 

	echo 'CONFIG_PROTECT="$CONFIG_PROTECT /usr/lib/oss/conf/"' > 99oss
	doenvd 99oss || die "doenvd failed"
}

pkg_postinst() {
	UPDATE_MODULEDB=true
	linux-mod_pkg_postinst

	ewarn "In order to use OSSv4 you must run"
	ewarn "# /etc/init.d/oss start "
	ewarn "If you are upgrading from a previous build of OSSv4 you must run"
	ewarn "# /etc/init.d/oss restart "
	ewarn 'and may need to remove /lib/modules/$KERNEL_VERSION/kernel/oss/'
}

pkg_postrm() {
	linux-mod_pkg_postrm
}
