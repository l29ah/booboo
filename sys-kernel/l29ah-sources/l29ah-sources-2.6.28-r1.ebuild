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

GENPATCHESV="2"
R4V=""
POHMELFSV="12"
TUXONICEV="3.0-rc8"

REISER4_URI="http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/reiser4-for-${PV}.patch.bz2"
TUXONICE_SRC="tuxonice-${TUXONICEV}-for-${PV}"
TUXONICE_URI="http://www.tuxonice.net/downloads/all/${TUXONICE_SRC}.patch.bz2"
POHMELFS_URI="http://tservice.net.ru/~s0mbre/archive/pohmelfs/pohmelfs.${POHMELFSV} -> pohmelfs.${POHMELFSV}.patch"

IUSE="${IUSE} reiser4 tuxonice pohmelfs +genpatches"	
# Defaults to gentoo-sources

SRC_URI="${KERNEL_URI} ${ARCH_URI}
	genpatches? ( ${GENPATCHES_URI} )
	reiser4? ( ${REISER4_URI} )
	pohmelfs? ( ${POHMELFS_URI} )
	tuxonice? ( ${TUXONICE_URI} )
"

if use genpatches; then
	K_WANT_GENPATCHES="base extras"
	K_GENPATCHES_VER="${GENPATCHESV}"
fi
if use reiser4; then 
	UNIPATCH_LIST="${UNIPATCH_LIST}
	${DISTDIR}/reiser4-for-${PV}${R4V}.patch.bz2
	${FILESDIR}/reiser4-2.6.28-add_to_page_cache_lru-fix.patch"
fi
if use pohmelfs; then 
	UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/pohmelfs.${POHMELFSV}.patch"
fi
if use tuxonice; then 
	UNIPATCH_LIST="${UNIPATCH_LIST} ${DISTDIR}/${TUXONICE_SRC}.patch.bz2"
fi

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

