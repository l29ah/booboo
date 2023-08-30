# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit fossil desktop

DESCRIPTION="GUI client for XMPP (Jabber) instant messaging protocol, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
IUSE="contrib -gpg +doc examples plugins 3rd-party-plugins ssl sound tkimg
trayicon +udp vanilla fix-site-plugins-path remote-controlling"

RDEPEND="
	>=dev-lang/tcl-8.5
	>=dev-lang/tk-8.5
	>=dev-tcltk/tcllib-1.6
	>=dev-tcltk/bwidget-1.3
	gpg? ( dev-tcltk/tclgpg )
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	sound? ( dev-tcltk/snack )
	trayicon? ( >=dev-tcltk/tktray-1.1 )
	tkimg? ( >=dev-tcltk/tkimg-1.4.6 )
	udp? ( dev-tcltk/tcludp )"
DEPEND="${DEPEND}
	doc? ( app-text/xml2rfc )"

LICENSE="GPL-2"
KEYWORDS=""
SLOT="0"

OFFICIAL_TKABBER_PLUGINS_DIR="${S}/plugins/official"
THIRD_PARTY_TKABBER_PLUGINS_DIR="${S}/plugins/3rd-party"
TKABBER_SITE_PLUGINS="/usr/share/tkabber/site-plugins"
INCOMPATIBLE_PLUGINS="pluginmanager"
TKIMG_DEPENDENT_PLUGINS="alarm vimage"

src_unpack() {
	fossil_fetch 'https://chiselapp.com/user/sgolovan/repository/tkabber' tkabber
	fossil_fetch 'https://chiselapp.com/user/sgolovan/repository/tclxmpp' tkabber/tclxmpp
	if use plugins; then
		fossil_fetch 'https://chiselapp.com/user/sgolovan/repository/tkabber-plugins' plugins/official
	fi
	if use 3rd-party-plugins; then
		fossil_fetch 'https://chiselapp.com/user/sgolovan/repository/tkabber-contrib' plugins/3rd-party
	fi
}

src_prepare() {
	if use vanilla; then
		return
	fi

	# Fix default official and third party plugins directory
	if use fix-site-plugins-path; then
		cd "${S}/tkabber" || die "Can't chdir to ${S}/tkabber"
		epatch "${FILESDIR}/tkabber.tcl.site.plugins.patch"
		sed -i -e 's#TKABBER_SITE_PLUGINS_PATH_PLACEHOLDER#'"${TKABBER_SITE_PLUGINS}"'#' \
			tkabber.tcl || die "Failed to fix default site plugins path in tkabber.tcl"
	fi

	default
}

src_compile() {
	if use 3rd-party-plugins && has vimage ${TKABBER_PLUGINS}; then
		cd "${THIRD_PARTY_TKABBER_PLUGINS_DIR}/vimage/lib/tkImageTools" \
			|| die "Cannot cd to tkImageTools"
		# Replace hardcoded tcl version
		if has_version ">=dev-lang/tcl-8.6"; then
			sed -i -e 's/MINOR_VERSION = 5/MINOR_VERSION = 6/' Makefile \
				|| die "Cannot patch tkImageTools Makefile"
		fi
		emake
	fi
}

src_install() {
	insinto "/usr/share/${PN}"
	cd "${S}/tkabber/" || die "Can't chdir to ${S}/tkabber/"

	local x
	local DOCSDIRS="doc examples contrib"

	for x in *; do
		if [[ -d "${x}" ]] ; then
			if ! has "${x}" ${DOCSDIRS} ; then
				doins -r "${x}"
			fi
		fi
	done

	sed -i -e 's#\[fullpath ChangeLog\]#"/usr/share/doc/'"$PF"'/ChangeLog"#' tkabber.tcl \
		|| die "Failed to fix Changelog fullpath in tkabber.tcl"

	doins *.tcl

	emake DESTDIR="${D}" PREFIX="/usr" install-bin

	if use doc ; then
		emake DESTDIR="${D}" PREFIX="/usr" DOCDIR="/usr/share/doc/${PF}" install-doc
	fi

	if use examples ; then
		emake DESTDIR="${D}" PREFIX="/usr" DOCDIR="/usr/share/doc/${PF}" install-examples
	fi

	if use contrib ; then
		insinto "/usr/share/doc/${PF}"
		doins -r contrib
	fi

	doicon "${FILESDIR}/${PN}.png"
	make_desktop_entry ${PN} Tkabber

	if use plugins || use 3rd-party-plugins; then
		TKABBER_PLUGINS="${TKABBER_PLUGINS:-}"

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
	use vanilla || rm -rf "$D/usr/share/tkabber/plugins/chat/shuffle.tcl" "$D/usr/share/tkabber/site-plugins/flip" || die

	# Remove the server trust (XEP-0146 support)
	use remote-controlling || rm -rf "$D/usr/share/tkabber/plugins/general/remote.tcl" || die
}

pkg_postinst() {
	einfo "By default tkabber uses an internal XML parser. You may want"
	einfo "to use an external one for (dubious) performance reasons,"
	einfo "in which case you may like to emerge dev-tcltk/tdom (and put"
	einfo "\"package require tdom\" in your ~/.tkabber/config.tcl)."
	einfo
	einfo "You may also optionally emerge dev-tcltk/tclx to theoretically"
	einfo "speed some other of tkabber's pure-Tcl operations up,"
	einfo "as you'd get them written in C. Real performance gains are"
	einfo "subject to further tests."
	einfo
	if ! use tkimg; then
		ewarn "dev-tcltk/tkimg adds support for PNG and JPG images, such as avatars,"
		ewarn "photos, non-default emoticons, etc. Some plugins, for example the"
		ewarn "\"alarm\" plugin may not function correctly without dev-tcltk/tkimg"
		ewarn
	fi
	plugins_inform
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

	# Verifying plugins existence.
	if [[ -n "$TKABBER_PLUGINS" ]]; then
		PLUGINS=( ${TKABBER_PLUGINS} )
		TKABBER_PLUGINS=""
		for i in "${PLUGINS[@]}"; do
			if has "${i}" ${AVAILABLE_PLUGINS}; then
				TKABBER_PLUGINS="${TKABBER_PLUGINS} ${i}"
			else
				ABSENT_PLUGINS="${ABSENT_PLUGINS} ${i}"
			fi
		done
		if [[ -n "${ABSENT_PLUGINS}" ]]; then
			ewarn
			ewarn "Following plugins specified in the TKABBER_PLUGINS environment variable"
			ewarn "are not present in the svn repositories:"
			ewarn
			ewarn "${ABSENT_PLUGINS}"
			ewarn
		fi
	fi

	if ! use tkimg; then
		PLUGINS=( ${TKABBER_PLUGINS:-${AVAILABLE_PLUGINS}} )
		for i in "${PLUGINS[@]}"; do
			if has "${i}" ${TKIMG_DEPENDENT_PLUGINS}; then
				DEPENDENT_PLUGINS="${DEPENDENT_PLUGINS} ${i}"
			fi
		done
		if [[ -n "${DEPENDENT_PLUGINS}" ]]; then
			eerror
			eerror "The \"tkimg\" USE-flag is not enabled, but the following plugins depend on dev-tcltk/tkimg:"
			eerror
			eerror "${DEPENDENT_PLUGINS}"
			eerror
			eerror "Please activate the \"tkimg\" USE-flag before installing these plugins"
			eerror
			die "\"tkimg\" USE-flag required, but not enabled."
		fi
	fi
}

plugins_inform() {
	if ! use plugins && ! use 3rd-party-plugins; then
		return
	fi

	if [[ -z "${TKABBER_PLUGINS}" ]]; then
		einfo "You selected to install plugins via the plugins and/or 3rd-party-plugins"
		einfo "USE variables. Please note, that if you wish to install only particular"
		einfo "plugins from all available ones, you need to specify them in the"
		einfo "TKABBER_PLUGINS variable in make.conf."
		einfo
		einfo "Currently the following plugins are available:"
		einfo
		einfo "${AVAILABLE_PLUGINS}"
		einfo
	fi
}

plugins_install() {
	insinto "${TKABBER_SITE_PLUGINS}"
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
		if has "${i}" ${EXISTING_PLUGINS}; then
			doins -r "${PLUGINS_DIR}/${i}"
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
		if ! has "${i}" ${EXISTING_OFFICIAL_TKABBER_PLUGINS}; then
			if ! has "${i}" ${INCOMPATIBLE_PLUGINS}; then
				EXISTING_THIRD_PARTY_TKABBER_PLUGINS="${EXISTING_THIRD_PARTY_TKABBER_PLUGINS} ${i}"
			fi
		else
			CONFLICTING_PLUGINS="${CONFLICTING_PLUGINS} ${i}"
		fi
	done

	if [[ -n "${CONFLICTING_PLUGINS}" ]]; then
		ewarn
		ewarn "Repositories have the following plugins duplicated,"
		ewarn "official versions of this plugins will be prefered:"
		ewarn "${CONFLICTING_PLUGINS}"
		ewarn
	fi
}
