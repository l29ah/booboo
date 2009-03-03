# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils flag-o-matic gnome2-utils multilib toolchain-funcs

DESCRIPTION="A lightweight web browser based on webkit-gtk"
HOMEPAGE="http://www.twotoasts.de/index.php?/pages/midori_summary.html"
SRC_URI="http://goodies.xfce.org/releases/${PN}/${P}.tar.bz2"

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

	# needed for force --as-needed, feel free to fix the build system
	append-ldflags -lgthread-2.0

	export LINKFLAGS="${LDFLAGS}"
	tc-export AR CC CPP RANLIB

	local myconf=""
	use doc && myconf+=" --enable-api-docs"
	use doc || myconf+=" --disable-docs"
	use minimal && myconf+=" --disable-extensions"
	use nls || myconf+=" --disable-nls"
	use soup || myconf+=" --disable-libsoup"
	use sqlite || myconf+=" --disable-sqlite"

	./waf \
		--prefix="/usr/" \
		--libdir="/usr/$(get_libdir)/" \
		--docdir="/usr/share/doc/${PF}/" \
		${myconf} \
		configure || die "waf configure failed."
	./waf build || die "waf build failed."
}

src_install() {
	./waf \
		--destdir="${D}" \
		install || die "waf install failed."
	dodoc AUTHORS ChangeLog HACKING README TODO TRANSLATE

	if use doc; then
		mv "${D}"/usr/share/doc/${PF}/midori/user "${D}"/usr/share/doc/${PF}/
		insinto /usr/share/doc/${PF}/
		doins -r _build_/docs/api
	fi
	rm -rf "${D}"/usr/share/doc/${PF}/${PN}/

	make_desktop_entry ${PN} Midori ${PN} Network
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
