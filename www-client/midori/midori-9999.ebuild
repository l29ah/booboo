# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit git gnome2-utils multilib toolchain-funcs

DESCRIPTION="A lightweight web browser based on webkit-gtk"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
EGIT_REPO_URI="git://git.xfce.org/kalikiana/${PN}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc minimal nls soup sqlite"

RDEPEND=">=dev-libs/glib-2.16:2
	dev-libs/libxml2
	net-libs/webkit-gtk
	>=x11-libs/gtk+-2.10:2
	soup? ( net-libs/libsoup:2.4 )
	sqlite? ( dev-db/sqlite )"
DEPEND="${RDEPEND}
	gnome-base/librsvg
	doc? ( dev-python/docutils
		dev-util/gtk-doc )
	nls? ( sys-devel/gettext
		dev-util/intltool )"

pkg_setup() {
	ewarn "Midori is not yet in a too mature status, so expect some minor things to break"
}

src_compile() {
	# borrowed from openoffice
	JOBS=`echo "${MAKEOPTS}" | sed -e "s/.*-j\([0-9]\+\).*/\1/"`
	[ "$JOBS" -gt 0 ] && export JOBS

	export LINKFLAGS="${LDFLAGS}"
	tc-export AR CC CPP RANLIB

	./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)/" \
		--docdir="/usr/share/doc/${PF}/" \
		$(use_enable nls) \
		$(use_enable soup libsoup) \
		$(use_enable sqlite) \
		$(use_enable doc userdocs) \
		$(use_enable doc apidocs) \
		$(use_enable !minimal addons) \
		configure || die "waf configure failed."
	./waf build || die "waf build failed."
}

src_install() {
	./waf \
		--destdir="${D}" \
		--disable-docs \
		install || die "waf install failed."
	dodoc AUTHORS ChangeLog HACKING README TODO TRANSLATE

	if use doc; then
		mv "${D}"/usr/share/doc/${PF}/midori/user "${D}"/usr/share/doc/${PF}/
		rmdir "${D}"/usr/share/doc/${PF}/midori/
		insinto /usr/share/doc/${PF}/
		doins -r _build_/docs/api
	fi
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
