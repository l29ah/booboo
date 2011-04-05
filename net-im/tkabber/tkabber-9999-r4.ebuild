# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=2

inherit subversion eutils

ESVN_REPO_URI="http://svn.xmpp.ru/repos/tkabber/trunk/tkabber"
ESVN_PROJECT="tkabber"
ESVN_RESTRICT="export"

DESCRIPTION="GUI client for XMPP (Jabber) instant messaging protocol, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
IUSE="contrib -crypt doc examples plugins 3rd-party-plugins ssl sound tkimg
trayicon vanilla"
sfn="tkabber-shitfree-r2.patch"
SRC_URI="!vanilla? (
	http://rain.ifmo.ru/~alirzaev/files/$sfn
				   )"

DEPEND="
	>=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	>=dev-tcltk/tcllib-1.6
	>=dev-tcltk/bwidget-1.3
	>=dev-tcltk/tkXwin-1.0
	crypt? ( dev-tcltk/tclgpg )
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	sound? ( dev-tcltk/snack )
	trayicon? ( >=dev-tcltk/tktray-1.1 )
	tkimg? ( >dev-tcltk/tkimg-1.4.20100510 )" # segfaulty crap
RDEPEND="${DEPEND}"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"

src_unpack() {
	subversion_fetch

	if use plugins; then
		ESVN_REPO_URI="http://svn.xmpp.ru/repos/tkabber/trunk/tkabber-plugins" \
		ESVN_PROJECT="tkabber/plugins/official/" \
		subversion_fetch
	fi

	if use 3rd-party-plugins; then
		ESVN_REPO_URI="http://svn.xmpp.ru/repos/tkabber-3rd-party/trunk/plugins" \
		ESVN_PROJECT="tkabber/plugins/3rd-party" \
		subversion_fetch
	fi
	ESVN_PROJECT="tkabber" subversion_export
}

src_prepare() {
	use vanilla || epatch "${DISTDIR}/$sfn"
}

src_compile() {
	echo
	einfo "Nothing to compile."
	echo
}

src_install() {
	dodir /usr/share/tkabber
	cd "${S}/tkabber/" || die "Can't chdir to ${S}/tkabber/"

	local x
	local DOCSDIRS="doc examples contrib"

	for x in *; do
		if [[ -d "${x}" ]] ; then
			if ! hasq "${x}" "${DOCSDIRS}" ; then
				cp -R "${x}" "${D}/usr/share/tkabber" \
			|| die "Can't copy ${x} to ${D}/usr/share/tkabber"
			fi
		fi
	done

	cp *.tcl "${D}/usr/share/tkabber" \
		|| die "Can't copy tcl files to ${D}/usr/share/tkabber"

	dosed "s:svn\[get_snapshot \[fullpath ChangeLog\]\]:svn-$(get_commit_date):" \
	/usr/share/tkabber/tkabber.tcl \
		|| die "Failed to fixate date of commit in tkabber.tcl"

	emake DESTDIR="${D}" PREFIX="/usr" install-bin || die "emake install failed."

	dodoc AUTHORS ChangeLog INSTALL README \
		|| die "Can't install tkabber documentation"

	if use doc ; then
		insinto "/usr/share/doc/${PF}"
		doins -r doc \
		|| die "Can't install extra tkabber documentation to ${D}/usr/share/doc/${PF}"
	fi
	if use examples ; then
		emake DESTDIR="${D}" PREFIX="/usr" install-examples || die "Can't install examples."
	fi
	if use contrib ; then
		insinto "/usr/share/doc/${PF}"
		doins -r contrib || die "Can't install additional contrib components to ${D}/usr/share/doc/${PF}"
	fi

	doicon "${FILESDIR}/${PN/-svn}.png"
	make_desktop_entry ${PN/-svn} Tkabber ${PN/-svn}.png

	if use plugins || use 3rd-party-plugins; then
		TKABBER_PLUGINS="${TKABBER_PLUGINS:-}"
		local OFFICIAL_TKABBER_PLUGINS_DIR="${S}/plugins/official/tkabber-plugins"
		local THIRD_PARTY_TKABBER_PLUGINS_DIR="${S}/plugins/3rd-party/plugins"
		local TKABBER_SITE_PLUGINS="/usr/share/tkabber/site-plugins"
		local INCOMPATIBLE_PLUGINS="pluginmanager"
		local TKIMG_DEPENDENT_PLUGINS="alarm"

		if use plugins; then
			local EXISTING_OFFICIAL_TKABBER_PLUGINS="$(dirlist "${OFFICIAL_TKABBER_PLUGINS_DIR}")"
		fi
		if use 3rd-party-plugins; then
			local EXISTING_THIRD_PARTY_TKABBER_PLUGINS="$(dirlist "${THIRD_PARTY_TKABBER_PLUGINS_DIR}")"
		fi

		cd "${S}" || die "Can't chdir to ${S}"

		plugins_verify \
			$(use plugins && echo official) \
			$(use 3rd-party-plugins && echo 3rd-party)

		if use plugins; then
			plugins_install official \
				|| die "Failed to install official plugins"
		fi

		if use 3rd-party-plugins; then
			plugins_install 3rd-party \
				|| die "Failed to install 3rd-party plugins"
		fi

		cd "${OFFICIAL_TKABBER_PLUGINS_DIR}" \
			|| die "Can't chdir to ${OFFICIAL_TKABBER_PLUGINS_DIR}"
		newdoc README README.plugins
		newdoc ChangeLog ChangeLog.plugins
	fi
	# Remove the fucking stupid shit
	use vanilla || rm -rf "$D/usr/share/tkabber/plugins/chat/shuffle.tcl" "$D/usr/share/tkabber/site-plugins/flip" 
}

pkg_postinst() {
	echo
	einfo "There's no UI option to disable emoticons yet, however"
	einfo "you can put the following into your ~/.tkabber/config.tcl"
	einfo
	einfo "hook::add finload_hook {"
	einfo " array unset emoteicons::emoteicons"
	einfo "}"
	echo
	einfo "By default tkabber uses an internal XML parser. You may want"
	einfo "to use an external one for (dubious) performance reasons,"
	einfo "in which case you may like to emerge dev-tcltk/tdom (and put"
	einfo "\"package require tdom\" in your ~/.tkabber/config.tcl)."
	echo
	einfo "You may also optionally emerge dev-tcltk/tclx to theoretically"
	einfo "speed some other of tkabber's pure-Tcl operations up,"
	einfo "as you'd get them written in C. Real performance gains are"
	einfo "subject to further tests."
	echo
	if ! use tkimg; then
		ewarn "dev-tcltk/tkimg adds support for PNG and JPG images, such as avatars,"
		ewarn "photos, non-default emoticons, etc. Some plugins, for example the"
		ewarn "\"alarm\" plugin may not function correctly without dev-tcltk/tkimg"
		echo
	fi
	plugins_inform
}

subversion_export() {
		cd "${ESVN_STORE_DIR}/${ESVN_PROJECT}" \
		|| die "Can't chdir to ${ESVN_STORE_DIR}/${ESVN_PROJECT}"

		mkdir -p "${S}"
		rsync -rlpgo --exclude=".svn/" . "${S}" \
		|| die "Can't export to ${S}."
}

# Getting list of directories in current or specified by argument directory.
dirlist() {
	local i
	local OUTPUT
	local TARGET_DIR
	if [[ -n "${1}" ]]; then
		[[ -d ${1} ]] || die "${1} directory not found"
		TARGET_DIR="${1}/"
	fi
	for i in ${TARGET_DIR}*; do
		[[ -d "${i}" ]] && OUTPUT="${OUTPUT} $(basename ${i})"
	done
	echo ${OUTPUT}
}

plugins_verify() {
	local PLUGINS
	local ABSENT_PLUGINS
	local DEPENDENT_PLUGINS
	local i
	AVAILABLE_PLUGINS=""

	until [ -z "$1" ] ; do
		case "${1}" in
			official)
			AVAILABLE_PLUGINS="${AVAILABLE_PLUGINS} ${EXISTING_OFFICIAL_TKABBER_PLUGINS}"
			;;
			3rd-party)
			fix_existing_third_party_tkabber_plugins
			AVAILABLE_PLUGINS="${AVAILABLE_PLUGINS} ${EXISTING_THIRD_PARTY_TKABBER_PLUGINS}"
			;;
			*)
			die "$0: wrong argument"
			;;
		esac
		shift
	done

# 	Verifying plugins existence.
	if [[ -n "$TKABBER_PLUGINS" ]]; then
		PLUGINS=( ${TKABBER_PLUGINS} )
		TKABBER_PLUGINS=""
		for i in "${PLUGINS[@]}"; do
			if hasq "${i}" "${AVAILABLE_PLUGINS}"; then
				TKABBER_PLUGINS="${TKABBER_PLUGINS} ${i}"
			else
				ABSENT_PLUGINS="${ABSENT_PLUGINS} ${i}"
			fi
		done
		if [[ -n "${ABSENT_PLUGINS}" ]]; then
			echo
			ewarn "Following plugins specified in the TKABBER_PLUGINS environment variable"
			ewarn "are not present in the svn repositories:"
			ewarn
			ewarn "${ABSENT_PLUGINS}"
			ewarn
			ewarn "You may want to cancel the installation by pressing ^c now and verify"
			ewarn "your settings. Waiting 5 seconds before continuing..."
			echo
			ebeep 5
			epause 5
		fi
	fi

	if ! use tkimg; then
		PLUGINS=( ${TKABBER_PLUGINS:-${AVAILABLE_PLUGINS}} )
		for i in "${PLUGINS[@]}"; do
			if hasq "${i}" "${TKIMG_DEPENDENT_PLUGINS}"; then
				DEPENDENT_PLUGINS="${DEPENDENT_PLUGINS} ${i}"
			fi
		done
		if [[ -n "${DEPENDENT_PLUGINS}" ]]; then
			echo
			eerror "The \"tkimg\" USE-flag is not enabled, but the following plugins depend on dev-tcltk/tkimg:"
			eerror
			eerror "${DEPENDENT_PLUGINS}"
			eerror
			eerror "Please activate the \"tkimg\" USE-flag before installing these plugins"
			echo
			die "\"tkimg\" USE-flag required, but not enabled."
		fi
	fi
}

plugins_inform() {
	if use plugins or use 3rd-party-plugins; then
		ewarn "You may need to refresh your profile (eg. login again)"
		ewarn "for the plugins to work."
		echo
		if [[ -z "${TKABBER_PLUGINS}" ]]; then
			einfo "You selected to install plugins via the plugins and/or 3rd-party-plugins"
			einfo "USE variables. Please note, that if you wish to install only particular"
			einfo "plugins from all available ones, you need to specify them in the"
			einfo "TKABBER_PLUGINS variable in make.conf."
			einfo
			einfo "Currently the following plugins are available:"
			einfo
			einfo "${AVAILABLE_PLUGINS}"
			echo
		fi
	fi
}

plugins_install() {
	local PLUGINS
	local EXISTING_PLUGINS
	local PLUGINS_DIR

	case "${1}" in
		official)
		EXISTING_PLUGINS="${EXISTING_OFFICIAL_TKABBER_PLUGINS}"
		PLUGINS_DIR="${OFFICIAL_TKABBER_PLUGINS_DIR}"
		;;
		3rd-party)
		EXISTING_PLUGINS="${EXISTING_THIRD_PARTY_TKABBER_PLUGINS}"
		PLUGINS_DIR="${THIRD_PARTY_TKABBER_PLUGINS_DIR}"
		;;
		*)
		die "$0: wrong argument"
		;;
	esac

	PLUGINS=( ${TKABBER_PLUGINS:-${EXISTING_PLUGINS}} )

	[[ -d "${D}/${TKABBER_SITE_PLUGINS}" ]] || mkdir "${D}/${TKABBER_SITE_PLUGINS}"
	for i in "${PLUGINS[@]}"; do
		if hasq "${i}" "${EXISTING_PLUGINS}"; then
			cp -R "${PLUGINS_DIR}/${i}" "${D}/${TKABBER_SITE_PLUGINS}" \
			|| echo "Can't copy ${PLUGINS_DIR}/${i} to ${D}/${TKABBER_SITE_PLUGINS}"
		fi
	done
}

# Fixing EXISTING_THIRD_PARTY_TKABBER_PLUGINS for avoiding collision of same plugins
# from different svn repositories and installation unix-incompatible plugins.
fix_existing_third_party_tkabber_plugins() {
	local PLUGINS=( ${EXISTING_THIRD_PARTY_TKABBER_PLUGINS} )
	local CONFLICTING_PLUGINS
	EXISTING_THIRD_PARTY_TKABBER_PLUGINS=""

	for i in "${PLUGINS[@]}"; do
		if ! hasq "${i}" "${EXISTING_OFFICIAL_TKABBER_PLUGINS}"; then
			if ! hasq "${i}" "${INCOMPATIBLE_PLUGINS}"; then
				EXISTING_THIRD_PARTY_TKABBER_PLUGINS="${EXISTING_THIRD_PARTY_TKABBER_PLUGINS} ${i}"
			fi
		else
			CONFLICTING_PLUGINS="${CONFLICTING_PLUGINS} ${i}"
		fi
	done

	if [[ -n "${CONFLICTING_PLUGINS}" ]]; then
		echo
		ewarn "Repositories have the following plugins duplicated,"
		ewarn "official versions of this plugins will be prefered:"
		ewarn "${CONFLICTING_PLUGINS}"
		echo
	fi
}

get_commit_date() {
	grep -m 1 -o -P "\d{4}-\d\d-\d\d" "${S}/tkabber/ChangeLog" \
	| sed s/'-'//g
}
