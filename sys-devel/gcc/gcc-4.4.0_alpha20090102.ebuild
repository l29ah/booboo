# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.3.2-r2.ebuild,v 1.0 2008/12/06 05:57:35 zorry Exp $

#PATCH_VER="1.2"
#UCLIBC_VER="1.0"

ETYPE="gcc-compiler"

# Hardened gcc 4 stuff
PIE_VER="10.1.2"
PIE_GCC_VER="4.4.0"
SPECS_VER="0.9.11"
SPECS_GCC_VER="4.3.2"

# arch/libc configurations known to be stable or untested with {PIE,SSP,FORTIFY}-by-default
SSP_STABLE="amd64 x86 ppc ppc64 ~arm ~sparc"
SSP_UCLIBC_STABLE=""
PIE_GLIBC_STABLE="x86 amd64 ppc ppc64 ~arm ~sparc"
PIE_UCLIBC_STABLE="x86 arm"
FORTIFY_STABLE="x86 amd64 ppc ppc64 ~arm ~sparc"
FORTIFY_UCLIBC_STABLE=""

# This patch is obsoleted by stricter control over how one builds a hardened
# compiler from a vanilla compiler.  By forbidding changing from normal to
# hardened between gcc stages, this is no longer necessary.
# GENTOO_PATCH_EXCLUDE="51_all_gcc-3.4-libiberty-pic.patch"
# Hardened end

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp+fortify extensions, Haj Ten Brugge runtime bounds checking"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~x86 ~ppc ~ppc64 ~arm ~sparc"

RDEPEND=">=sys-libs/zlib-1.1.4
	>=sys-devel/gcc-config-1.4
	virtual/libiconv
	>=dev-libs/gmp-4.2.1
	>=dev-libs/mpfr-2.3
	!build? (
		gcj? (
			gtk? (
				x11-libs/libXt
				x11-libs/libX11
				x11-libs/libXtst
				x11-proto/xproto
				x11-proto/xextproto
				>=x11-libs/gtk+-2.2
				x11-libs/pango
			)
			>=media-libs/libart_lgpl-2.1
			app-arch/zip
			app-arch/unzip
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"
DEPEND="${RDEPEND}
	test? ( sys-devel/autogen dev-util/dejagnu )
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	amd64? ( >=sys-libs/glibc-2.7-r2 )
	ppc? ( >=${CATEGORY}/binutils-2.17 )
	ppc64? ( >=${CATEGORY}/binutils-2.17 )
	>=${CATEGORY}/binutils-2.17"
PDEPEND=">=sys-devel/gcc-config-1.4"
if [[ ${CATEGORY} != cross-* ]] ; then
	PDEPEND="${PDEPEND} elibc_glibc? ( >=sys-libs/glibc-2.6 )"
fi
src_unpack() {
	gcc_src_unpack

	use vanilla && return 0

	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env.patch

	[[ ${CTARGET} == *-softfloat-* ]] && epatch "${FILESDIR}"/4.3.2/gcc-4.3.2-softfloat.patch

	if use hardened ; then
	
	    einfo "Hardened toolchain for GCC 4 is made by zorry, psm and xake"
	    einfo "http://forum.gentoo.org/viewtopic-t-668885.html"
	    einfo "https://hardened.gentooexperimental.org/trac/secure"
	    einfo "Thanks KernelOfTruth, dw and everyone else helping testing, suggesting fixes and other things we have missed."
	    einfo "/zorry"
	fi
}
