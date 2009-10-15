# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

# @ECLASS: xfce4.eclass
# @MAINTAINER: Christoph Mende <angelos@gentoo.org>
# Gentoo's Xfce Team <xfce@gentoo.org>
# @BLURB: functions to simplify Xfce4 package installation
# @DESCRIPTION:
# This eclass provides functions to install Xfce4 packages with a
# minimum of duplication in ebuilds

inherit fdo-mime gnome2-utils libtool
[ -n ${XFCE4_PATCHES} ] && inherit eutils
if [ ${PV} = 9999 ]; then
	inherit autotools
	inherit git
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

[ ${PV} = 9999 -a -z "${XFCE_VERSION}" ] && XFCE_VERSION="4.6.0"
[ -z ${XFCE_VERSION} ] && XFCE_VERSION=${PV}
[ -z ${THUNAR_VERSION} ] && THUNAR_VERSION="0.9"

if [ ${PV} = 9999 ]; then
	[ -n "${WANT_GTKDOCIZE}" ] && DEPEND+=" dev-util/gtk-doc"
	[ ${PN} != xfce4-dev-tools ] && DEPEND+="
		>=dev-util/xfce4-dev-tools-${XFCE_VERSION}"
fi


# @FUNCTION: xfce4_apps
# @DESCRIPTION:
# Change SRC_URI (or EGIT_REPO_URI for live ebuilds)
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_uri() {
	[ -z ${MY_P} ] && MY_P=${MY_PN:-${PN}}-${MY_PV:-${PV}}
	S="${WORKDIR}/${MY_P}"

	if [ ${PV} = 9999 ]; then
		EGIT_REPO_URI="git://git.xfce.org/${XFCE_CAT}/${MY_PN:-${PN}}"
	else
		SRC_URI="http://git.xfce.org/${XFCE_CAT}/${MY_PN:-${PN}}/snapshot/${MY_P}${COMPRESS}"
	fi
}

# @FUNCTION: xfce4_apps
# @DESCRIPTION:
# Call xfce4_uri and set HOMEPAGE
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_apps() {
	XFCE_CAT="apps"
	xfce4_uri
	[ -z ${HOMEPAGE} ] && HOMEPAGE="http://www.xfce.org/projects/"
}

# @FUNCTION: xfce4_libs
# @DESCRIPTION:
# Call xfce4_uri and set HOMEPAGE
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_libs() {
	XFCE_CAT="libs"
	xfce4_uri
}

# @FUNCTION: xfce4_archive
# @DESCRIPTION:
# Call xfce4_uri and set HOMEPAGE
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_archive() {
	XFCE_CAT="archive"
	xfce4_uri
	[ -z ${HOMEPAGE} ] && HOMEPAGE="http://www.xfce.org/projects"
}

# @FUNCTION: xfce4_art
# @DESCRIPTION:
# Call xfce4_uri and set HOMEPAGE
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_art() {
	XFCE_CAT="art"
	xfce4_uri
	#[ -z ${HOMEPAGE} ] && HOMEPAGE="http://www.xfce.org/projects"
}

# @FUNCTION: xfce4_panel_plugin
# @DESCRIPTION:
# Call xfce4_uri and RDEPEND on xfce4-panel and set HOMEPAGE to the panel plugins homepage
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_panel_plugin() {
	XFCE_CAT="panel-plugins"
	xfce4_uri
	[ -z ${HOMEPAGE} ] && HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/${MY_PN}"
	RDEPEND="${RDEPEND} >=xfce-base/xfce4-panel-${XFCE_VERSION}"
	DEPEND="${DEPEND} >=xfce-base/xfce4-panel-${XFCE_VERSION}"
}

# @FUNCTION: xfce4_thunar_plugin
# @DESCRIPTION:
# Call xfce4_uri, RDEPEND on thunar and set HOMEPAGE to the thunar plugins homepage
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_thunar_plugin() {
	XFCE_CAT="thunar-plugins"
	xfce4_uri
	[ -z ${HOMEPAGE} ] && HOMEPAGE="http://thunar.xfce.org/plugins.html"
	RDEPEND="${RDEPEND} >=xfce-base/thunar-${THUNAR_VERSION}"
	DEPEND="${DEPEND} >=xfce-base/thunar-${THUNAR_VERSION}"
}

# @FUNCTION: xfce4_core
# @DESCRIPTION:
# Call xfce4_uri and set the HOMEPAGE to www.xfce.org
# Note: git ebuilds usually require XFCE_CAT (for example apps for xfce4-notifyd)
xfce4_core() {
	XFCE_CAT="xfce"
	xfce4_uri
	[ -z ${HOMEPAGE} ] && HOMEPAGE="http://www.xfce.org/"
}

# @FUNCTION: xfce4_single_make
# @DESCRIPTION:
# Build with one job for broken parallel builds
xfce4_single_make() {
	JOBS="-j1"
}

# @FUNCTION: xfce4_src_unpack
# @DESCRIPTION:
# Only used for live ebuilds. Patch autogen.sh to inject the correct revision
# into configure.ac
xfce4_src_unpack() {
	if [ ${PV} = 9999 ]; then
		local revision
		XFCE_CONFIG+=" --enable-maintainer-mode"
		git_src_unpack
		cd ${S}
		revision=$(git show --pretty=format:%ci | head -n 1 | \
		awk '{ gsub("-", "", $1); print $1"-"; }')
		revision+=$(git rev-parse HEAD | cut -c1-8)

		local linguas
		[ -d po ] && linguas="$(sed -e '/^#/d' po/LINGUAS)"
		[ -n "${XFCE4_PATCHES}" ] && epatch ${XFCE4_PATCHES}
		if [ -f configure.??.in ]; then
			[ -f configure.ac.in ] && configure=configure.ac.in
			[ -f configure.in.in ] && configure=configure.in.in
			[ -n "${linguas}" ] && sed -i -e "s/@LINGUAS@/${linguas}/g" ${configure}
			sed -i -e "s/@REVISION@/${revision}/g" ${configure}
			cp ${configure} ${configure/.in}
		fi
		if [ -f configure.?? ]; then
			[ -f configure.ac ] && configure=configure.ac
			[ -f configure.in ] && configure=configure.in
			[ ${PN} != xfce4-dev-tools ] && AT_M4DIR="/usr/share/xfce4/dev-tools/m4macros"
			[ -n "${WANT_GTKDOCIZE}" ] && gtkdocize --copy
			if [ -d po ]; then
			grep -Eqs "^(AC|IT)_PROG_INTLTOOL" ${configure} \
				&& intltoolize --automake --copy --force \
				|| glib-gettextize --copy --force >/dev/null
			fi
			eautoreconf
		fi
	else
		unpack ${A}
		cd "${S}"
		[ -n "${XFCE4_PATCHES}" ] && epatch ${XFCE4_PATCHES}
		elibtoolize
	fi
}

# @FUNCTION: xfce4_src_configure
# @DESCRIPTION:
# Package configuration
# XFCE_CONFIG is used for additional econf/autogen.sh arguments
# startup-notification and debug are automatically added when they are found in
# IUSE
xfce4_src_configure() {
	has startup-notification ${IUSE} && \
		XFCE_CONFIG+=" $(use_enable startup-notification)"

	has debug ${IUSE} && XFCE_CONFIG+=" $(use_enable debug)"

	econf ${XFCE_CONFIG}
}

# @FUNCTION: xfce4_src_compile
# @DESCRIPTION:
# Package compilation
# Calls xfce4_src_configure for EAPI <= 1 and runs emake with ${JOBS}
xfce4_src_compile() {
	[ "${EAPI}" -le 1 ] && xfce4_src_configure
	emake ${JOBS} || die "emake failed"
}

# @FUNCTION: xfce4_src_install
# @DESCRIPTION:
# Package installation
# The content of $DOCS is installed via dodoc
xfce4_src_install() {
	[ -n "${DOCS}" ] && dodoc ${DOCS}

	emake DESTDIR="${D}" install || die "emake install failed"
}

# @FUNCTION: xfce4_pkg_preinst
# @DESCRIPTION:
# Run gnome2_icon_savelist for the following gnome2_icon_cache_update
xfce4_pkg_preinst() {
	gnome2_icon_savelist
}

# @FUNCTION: xfce4_pkg_postinst
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfce4_pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

# @FUNCTION: xfce4_pkg_postrm
# @DESCRIPTION:
# Run fdo-mime_{desktop,mime}_database_update and gnome2_icon_cache_update
xfce4_pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

EXPORT_FUNCTIONS src_unpack src_configure src_compile src_install pkg_preinst pkg_postinst pkg_postrm
