# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

#NEED_KDE=":kde-4"
inherit subversion kde4-base

# Install to KDEDIR rather than /usr, to slot properly.
PREFIX="${KDEDIR}"

DESCRIPTION="An advanced twin-panel (commander-style) file-manager for
KDE with many extras."
HOMEPAGE="http://www.krusader.org"
ESVN_REPO_URI="http://krusader.svn.sourceforge.net/svnroot/krusader/trunk/krusader_kde4"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="kde-4"
IUSE=""

DEPEND=""
RDEPEND="kde-base/kdebase-data:4.2"

src_unpack() {
	local cleandir
	cleandir="${ESVN_STORE_DIR}/KDE/KDE"
	if [[ -d ${cleandir} ]]; then
		eerror "'${cleandir}' should never have been created. Either move it to"
		eerror "${ESVN_STORE_DIR}/${ESVN_PROJECT}/${ESVN_REPO_URI##*/} or remove"
		eerror "completely."
		die "'${cleandir}' is in the way."
	fi

	subversion_src_unpack
	kde4-base_apply_patches
}
