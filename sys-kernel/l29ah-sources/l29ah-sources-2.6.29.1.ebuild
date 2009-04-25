# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
ETYPE="sources"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
HOMEPAGE="http://wiki.github.com/l29ah/booboo"
DESCRIPTION="Full sources with some useful patches."
#UNIPATCH_STRICTORDER="yes"

inherit kernel-2
detect_version
detect_arch

GENPATCHESV="2"
REISER4V="2.6.29"

REISER4_SRC="reiser4-for-${REISER4V}.patch.bz2"
REISER4_URI="http://www.kernel.org/pub/linux/kernel/people/edward/reiser4/reiser4-for-${KV_MAJOR}.${KV_MINOR}/${REISER4_SRC}"

IUSE="${IUSE} reiser4 +genpatches"  
# Defaults to gentoo-sources

SRC_URI="${KERNEL_URI} ${ARCH_URI}
  reiser4? ( ${REISER4_URI} )
"

if use genpatches; then
	K_WANT_GENPATCHES="base extras"
	K_GENPATCHES_VER="${GENPATCHESV}"
fi
if use reiser4; then
	UNIPATCH_LIST="${UNIPATCH_LIST}
	${DISTDIR}/${REISER4_SRC}"
fi

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}
