EAPI=2

inherit base git-r3

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="https://github.com/mcabber/loudmouth"
# The official repo is dead; trying the mcabber-forked one
#EGIT_REPO_URI="git://github.com/engineyard/loudmouth.git"
EGIT_REPO_URI="git://github.com/mcabber/loudmouth.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""

IUSE="openssl gnutls doc"

RDEPEND=">=dev-libs/glib-2.4
    gnutls? ( >=net-libs/gnutls-1.4.0 )
	openssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( 
		>=dev-util/gtk-doc-am-1
		<dev-util/gtk-doc-1.12 
	)"	# Dunno why, but it fails w/ recent versions

use doc && DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	sed -i -e 's/-Werror//' acinclude.m4
	use doc && {
		./autogen.sh
	} || {
		epatch "$FILESDIR/${PN}-nodocs.patch"
		./autogen.sh -n
	}
}

src_configure() {
	use openssl && {
		use gnutls && 
			eerror "openssl and gnutls USE flags are mutually exclusive" && die || 
				c="--with-ssl=openssl $c"
	} || use gnutls || c="--with-ssl=no $c"

	econf --disable-dependency-tracking $c
}

src_install() {
	einstall
}

