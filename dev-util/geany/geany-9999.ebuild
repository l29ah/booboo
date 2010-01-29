# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/geany/geany-0.17.ebuild,v 1.2 2009/05/06 17:37:46 ssuominen Exp $

EAPI=2
inherit autotools gnome2-utils subversion

DESCRIPTION="GTK+ based fast and lightweight IDE"
HOMEPAGE="http://geany.uvena.de"
ESVN_REPO_URI="https://geany.svn.sourceforge.net/svnroot/geany/trunk"
unset SRC_URI

LICENSE="GPL-2 Scintilla"
SLOT="0"
KEYWORDS=""
IUSE="+vte"

RDEPEND=">=x11-libs/gtk+-2.10:2
	>=dev-libs/glib-2.16:2
	vte? ( x11-libs/vte )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	sys-devel/gettext"

src_prepare() {
	# Syntax highlighting for Portage
	sed -i -e "s:*.sh;:*.sh;*.ebuild;*.eclass;:" \
		data/filetype_extensions.conf || die "sed failed"

	# This tarball was generated with broken intltool
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf --disable-dependency-tracking \
		--enable-the-force $(use_enable vte)
}

src_install() {
	emake DESTDIR="${D}" DOCDIR="${D}/usr/share/doc/${PF}" \
		install || die "emake install failed"
	rm -f "${D}"/usr/share/doc/${PF}/{COPYING,GPL-2,ScintillaLicense.txt}
	prepalldocs
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
