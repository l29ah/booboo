# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ETYPE="sources"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
HOMEPAGE="http://l29ah.ru/"
DESCRIPTION="Full sources with some useful patches."
#UNIPATCH_STRICTORDER="yes"

inherit kernel-2
detect_version
detect_arch

#GENPATCHESV="2"
R4V=""
TUXONICEV="3.0-rc8"

REISER4_SRC="reiser4-for-2.6.28.patch.bz2"
REISER4_URI="http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/${REISER4_SRC}"
TUXONICE_SRC="tuxonice-${TUXONICEV}-for-2.6.28.patch.bz2"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}"

IUSE="${IUSE} reiser4 tuxonice +genpatches"	
# Defaults to gentoo-sources

SRC_URI="${KERNEL_URI} ${ARCH_URI}
	reiser4? ( ${REISER4_URI} )
"

if use genpatches; then
	ewarn "No genpatches in RC"
	#K_WANT_GENPATCHES="base extras"
	#K_GENPATCHES_VER="${GENPATCHESV}"
fi
if use reiser4; then 
	ewarn "Using Reiser4 for .28"
	UNIPATCH_LIST="${UNIPATCH_LIST}
	${DISTDIR}/${REISER4_SRC}"
	# Strange stuff in -rc6
	#${FILESDIR}/reiser4-2.6.28-add_to_page_cache_lru-fix.patch"
fi
if use tuxonice; then 
	ewarn "No TuxOnIce for .29 yet, and TuxOnIce for .28 fails to apply."
	#UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${TUXONICE_SRC}"
fi

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

