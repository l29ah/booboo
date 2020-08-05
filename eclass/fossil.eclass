# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#
# Original Author: l29ah
# Purpose: fuck you
#

inherit eutils

EFOSSIL="$ECLASS"

case "${EAPI:-0}" in
	0|1|2|3|4) die "this eclass doesn't support older EAPIs" ;;
esac

EXPORT_FUNCTIONS src_unpack

PROPERTIES+=" live"

[[ -z ${EFOSSIL_STORE_DIR} ]] && EFOSSIL_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/fossil-src"


EFOSSIL_PROJECT="${EFOSSIL_PROJECT:-${PN/-fossil}}"

fossil_fetch() {
	local repo_uri="${1:-${EFOSSIL_REPO_URI}}"
	local S_dest="${2}"

	addwrite "${EFOSSIL_STORE_DIR}"
	if [[ ! -d ${EFOSSIL_STORE_DIR} ]]; then
		debug-print "${FUNCNAME}: initial checkout. creating fossil directory"
		mkdir -m 775 -p "${EFOSSIL_STORE_DIR}" || die "${EFOSSIL}: can't mkdir ${EFOSSIL_STORE_DIR}."
	fi
	pushd "${EFOSSIL_STORE_DIR}" >/dev/null || die "${EFOSSIL}: can't chdir to ${EFOSSIL_STORE_DIR}"
	mkdir -m 775 -p "${EFOSSIL_PROJECT}" || die "${EFOSSIL}: can't mkdir ${EFOSSIL_PROJECT}."
	cloned_repo="${EFOSSIL_STORE_DIR}/${EFOSSIL_PROJECT}/${repo_uri##*/}"
	if [[ -e "$cloned_repo" ]]; then
		fossil --user portage pull -R "$cloned_repo" "$repo_uri" || die "${EFOSSIL}: can't pull ${repo_uri}."
	else
		fossil --user portage clone "$repo_uri" "$cloned_repo" || die "${EFOSSIL}: can't clone ${repo_uri}."
	fi

	if ! has "export" ${EFOSSIL_RESTRICT}; then
		local S="${S}/${S_dest}"
		mkdir -p "${S}"
		cd "$S"
		fossil open --nested "$cloned_repo"
	fi

	popd >/dev/null
}

fossil_src_unpack() {
	fossil_fetch
}

DEPEND+=" dev-vcs/fossil"
