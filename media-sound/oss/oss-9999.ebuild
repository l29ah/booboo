# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2 linux-mod

EGIT_REPO_URI="http://git.code.sf.net/p/opensound/git"
EGIT_PROJECT="$PN"

DESCRIPTION="Open Sound System - portable, mixing-capable, high quality sound system for Unix."
HOMEPAGE="http://developer.opensound.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="salsa midi vmix_fixedpoint"

DEPEND="sys-apps/gawk
	>=x11-libs/gtk+-2
	>=sys-kernel/linux-headers-2.6.11"
RDEPEND=">=x11-libs/gtk+-2"

S="${WORKDIR}/build"

src_unpack() {
	S="$WORKDIR/opensound" git-2_src_unpack
	mkdir "${WORKDIR}/build"
}

src_prepare() {
	cd "$WORKDIR/opensound"
	epatch "$FILESDIR/oss-4.2.2008-linux-3.12.patch"

	einfo "Replacing init script with gentoo friendly one..."
	cp "${FILESDIR}/oss" setup/Linux/oss/etc/S89oss
}

src_configure() {
	local myconf="$(use salsa && echo  || echo --enable-libsalsa=NO) \
		--config-midi=$(use midi && echo YES || echo NO) \
		--config-vmix=$(use vmix_fixedpoint && echo FIXEDPOINT || echo FLOAT)"
	
	cd "${WORKDIR}/build"
	"$WORKDIR/opensound/configure" $myconf || die "configure failed"

	einfo "Stripping compiler flags..."
	sed -i -e 's/-D_KERNEL//' \
		"${WORKDIR}/build/Makefile" || die 'sed failed'
}

src_compile() {
	emake build || die "emake build failed"
}

src_install() {
	newinitd "${FILESDIR}"/oss oss
	cd "${WORKDIR}/build"
	cp -R prototype/* "${D}"

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
