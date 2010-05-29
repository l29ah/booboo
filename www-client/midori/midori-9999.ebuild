inherit git
DESCRIPTION="Midori is a Web Browser, that aims to be lightweight and fast. It
aligns well with the Xfce philosophy of making the most out of available
resources. "
HOMEPAGE="https://launchpad.net/midori"
SRC_URI=""

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="doc minimal nls soup sqlite"
EGIT_REPO_URI="git://git.xfce.org/apps/midori"

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
src_compile()
{
	./waf configure --prefix=/usr \
					--disable-docs \
					--disable-userdocs \
					--disable-apidocs \
					--enable-addons \
					--debug-level=none || die
		
	./waf build || die "waf build failed."
}

src_install()
{
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
