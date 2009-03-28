# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

inherit eutils

EGCLIENT="${ECLASS}"

EXPORT_FUNCTIONS src_unpack pkg_preinst

DESCRIPTION="Based on the ${ECLASS} eclass"

DEPEND="dev-util/gclient
	dev-util/subversion"

# @ECLASS-VARIABLE: EGCLIENT_STORE_DIR
# @DESCRIPTION:
# gclient sources store directory. Users may override this in /etc/make.conf
[[ -z ${EGCLIENT_STORE_DIR} ]] && EGCLIENT_STORE_DIR="${PORTAGE_ACTUAL_DISTDIR:-${DISTDIR}}/gclient-src"

# @ECLASS-VARIABLE: EGCLIENT_CONFIG_CMD
# @DESCRIPTION:
# gclient config command
EGCLIENT_CONFIG_CMD="gclient.py config"

# @ECLASS-VARIABLE: EGCLIENT_FETCH_CMD
# @DESCRIPTION:
# gclient sync command
EGCLIENT_UPDATE_CMD="gclient.py update"

# @ECLASS-VARIABLE: EGCLIENT_REPO_URI
# @DESCRIPTION:
# repository uri
#
EGCLIENT_REPO_URI="${EGCLIENT_REPO_URI:-}"

# @ECLASS-VARIABLE: EGCLIENT_CONFIG
# @DESCRIPTION:
# custom config file
#
EGCLIENT_CONFIG="${EGCLIENT_CONFIG:-}"

# @ECLASS-VARIABLE: EGCLIENT_PROJECT
# @DESCRIPTION:
# project name of your ebuild (= name space)
#
# subversion eclass will check out the subversion repository like:
#
#   ${EGCLIENT_STORE_DIR}/${EGCLIENT_PROJECT}/${EGCLIENT_REPO_URI##*/}
#
# so if you define EGCLIENT_REPO_URI as http://svn.collab.net/repo/svn/trunk or
# http://svn.collab.net/repo/svn/trunk/. and PN is subversion-svn.
# it will check out like:
#
#   ${EGCLIENT_STORE_DIR}/subversion/trunk
#
# this is not used in order to declare the name of the upstream project.
# so that you can declare this like:
#
#   # jakarta commons-loggin
#   EGCLIENT_PROJECT=commons/logging
#
# default: ${PN/-svn}.
EGCLIENT_PROJECT="${EGCLIENT_PROJECT:-${PN/-svn}}"

# @ECLASS-VARIABLE: ESCM_LOGDIR
# @DESCRIPTION:
# User configuration variable. If set to a path such as e.g. /var/log/scm any
# package inheriting from subversion.eclass will record svn revision to
# ${CATEGORY}/${PN}.log in that path in pkg_preinst. This is not supposed to be
# set by ebuilds/eclasses. It defaults to empty so users need to opt in.
ESCM_LOGDIR="${ESCM_LOGDIR:=}"

# @FUNCTION: subversion_fetch
# @USAGE: [repo_uri] [destination]
# @DESCRIPTION:
# Wrapper function to fetch sources via gclient sync or gclient update,
# depending on whether there is an existing working copy in ${EGCLIENT_STORE_DIR}.
#
# Can take two optional parameters:
#   repo_uri    - a repository URI. default is EGCLIENT_REPO_URI.
#   destination - a check out path in S.
gclient_fetch() {
	local repo_uri="$(subversion__get_repository_uri "${1:-${EGCLIENT_REPO_URI}}")"
	local S_dest="${2}"

	if [[ -z ${repo_uri} ]]; then
		die "${EGCLIENT}: EGCLIENT_REPO_URI (or specified URI) is empty."
	fi

	# check for the protocol
	local protocol="${repo_uri%%:*}"

	case "${protocol}" in
		http|https)
			if ! built_with_use --missing true -o dev-util/subversion webdav-neon webdav-serf || \
			built_with_use --missing false dev-util/subversion nowebdav ; then
				echo
				eerror "In order to emerge this package, you need to"
				eerror "reinstall Subversion with support for WebDAV."
				eerror "Subversion requires either Neon or Serf to support WebDAV."
				echo
				die "${EGCLIENT}: reinstall Subversion with support for WebDAV."
			fi
			;;
		svn|svn+ssh)
			;;
		*)
			die "${EGCLIENT}: fetch from '${protocol}' is not yet implemented."
			;;
	esac

	addread "/etc/subversion"
	addwrite "${EGCLIENT_STORE_DIR}"

	if [[ ! -d ${EGCLIENT_STORE_DIR} ]]; then
		mkdir -p "${EGCLIENT_STORE_DIR}" || die "${EGCLIENT}: can't mkdir ${EGCLIENT_STORE_DIR}."
	fi

	cd "${EGCLIENT_STORE_DIR}" || die "${EGCLIENT}: can't chdir to ${EGCLIENT_STORE_DIR}"

        local wc_path="$(subversion__get_wc_path "${repo_uri}")"

	if [[ ! -d ${EGCLIENT_PROJECT} ]]; then
		mkdir -p "${EGCLIENT_PROJECT}" || die "${EGCLIENT}: can't mkdir ${EGCLIENT_PROJECT}."
	fi

	cd "${EGCLIENT_PROJECT}" || die "${EGCLIENT}: can't chdir to ${EGCLIENT_PROJECT}"

	if [[ -n ${EGCLIENT_CONFIG} ]]; then
		einfo "Using custom .gclient file: ${EGCLIENT_CONFIG}"
		cp ${EGCLIENT_CONFIG} .
	fi

	if [[ ! -f .gclient ]]; then
		${EGCLIENT_CONFIG_CMD} "${repo_uri}" || die "${EGCLIENT}: error creating config"
	fi

	einfo "gclient update-->"
	einfo "     repository: ${repo_uri}${revision:+@}${revision}"
	${EGCLIENT_UPDATE_CMD} || die "${EGCLIENT}: can't fetch to ${wc_path} from ${repo_uri}."

	echo
        einfo "   working copy: ${wc_path}"

	cd "${wc_path}" || die "${EGCLIENT}: can't chdir to ${wc_path}"
	local S="${S}/${S_dest}"
	mkdir -p "${S}"
	rsync -rlpgo --exclude=".svn/" . "${S}" || die "${EGCLIENT}: can't export to ${S}."

        echo

}

# @FUNCTION: subversion_src_unpack
# @DESCRIPTION:
# default src_unpack. fetch
gclient_src_unpack() {
	gclient_fetch     || die "${EGCLIENT}: unknown problem occurred in gclient_fetch."
}

# @FUNCTION: subversion_wc_info
# @USAGE: [repo_uri]
# @RETURN: EGCLIENT_WC_URL, EGCLIENT_WC_ROOT, EGCLIENT_WC_UUID, EGCLIENT_WC_REVISION and EGCLIENT_WC_PATH
# @DESCRIPTION:
# Get svn info for the specified repo_uri. The default repo_uri is EGCLIENT_REPO_URI.
#
# The working copy information on the specified repository URI are set to
# EGCLIENT_WC_* variables.
subversion_wc_info() {
	local repo_uri="$(subversion__get_repository_uri "${1:-${EGCLIENT_REPO_URI}}")"
	local wc_path="$(subversion__get_wc_path "${repo_uri}")"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"
	debug-print "${FUNCNAME}: wc_path = ${wc_path}"

	if [[ ! -d ${wc_path} ]]; then
		return 1
	fi

	export EGCLIENT_WC_URL="$(subversion__svn_info "${wc_path}" "URL")"
	export EGCLIENT_WC_ROOT="$(subversion__svn_info "${wc_path}" "Repository Root")"
	export EGCLIENT_WC_UUID="$(subversion__svn_info "${wc_path}" "Repository UUID")"
	export EGCLIENT_WC_REVISION="$(subversion__svn_info "${wc_path}" "Revision")"
	export EGCLIENT_WC_PATH="${wc_path}"
}

## -- Private Functions

## -- subversion__svn_info() ------------------------------------------------- #
#
# param $1 - a target.
# param $2 - a key name.
#
subversion__svn_info() {
	local target="${1}"
	local key="${2}"

	env LC_ALL=C svn info "${target}" | grep -i "^${key}" | cut -d" " -f2-
}

## -- subversion__get_repository_uri() --------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_repository_uri() {
	 local repo_uri="${1}"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	if [[ -z ${repo_uri} ]]; then
		die "${EGCLIENT}: EGCLIENT_REPO_URI (or specified URI) is empty."
	fi

	# delete trailing slash
	if [[ -z ${repo_uri##*/} ]]; then
		repo_uri="${repo_uri%/}"
	fi

	repo_uri="${repo_uri%@*}"

	echo "${repo_uri}"
}

## -- subversion__get_wc_path() ---------------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_wc_path() {
	local repo_uri="$(subversion__get_repository_uri "${1}")"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	echo "${EGCLIENT_STORE_DIR}/${EGCLIENT_PROJECT}/${repo_uri##*/}"
}

## -- subversion__get_peg_revision() ----------------------------------------- #
#
# param $1 - a repository URI.
subversion__get_peg_revision() {
	local repo_uri="${1}"

	debug-print "${FUNCNAME}: repo_uri = ${repo_uri}"

	# repo_uri has peg revision ?
	if [[ ${repo_uri} != *@* ]]; then
		debug-print "${FUNCNAME}: repo_uri does not have a peg revision."
	fi

	local peg_rev=
	[[ ${repo_uri} = *@* ]] &&  peg_rev="${repo_uri##*@}"

	debug-print "${FUNCNAME}: peg_rev = ${peg_rev}"

	echo "${peg_rev}"
}

# @FUNCTION: gclient_pkg_preinst
# @USAGE: [repo_uri]
# @DESCRIPTION:
# Log the svn revision of source code. Doing this in pkg_preinst because we
# want the logs to stick around if packages are uninstalled without messing with
# config protection.
gclient_pkg_preinst() {
	local pkgdate=$(date "+%Y%m%d %H:%M:%S")
	subversion_wc_info "${1:-${EGCLIENT_REPO_URI}}"
	if [[ -n ${ESCM_LOGDIR} ]]; then
		local dir="${ROOT}/${ESCM_LOGDIR}/${CATEGORY}"
		if [[ ! -d ${dir} ]]; then
			mkdir -p "${dir}" || \
				eerror "Failed to create '${dir}' for logging svn revision to '${PORTDIR_SCM}'"
		fi
		local logmessage="svn: ${pkgdate} - ${PF}:${SLOT} was merged at revision ${EGCLIENT_WC_REVISION}"
		if [[ -d ${dir} ]]; then
			echo "${logmessage}" >> "${dir}/${PN}.log"
		else
			eerror "Could not log the message '${logmessage}' to '${dir}/${PN}.log'"
		fi
	fi
}
