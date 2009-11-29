inherit git

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.loudmouth-project.org/"
SRC_URI=""
# The official repo is dead; trying the mcabber-forked one
#EGIT_REPO_URI="git://github.com/engineyard/loudmouth.git"
EGIT_REPO_URI="git://github.com/mcabber/loudmouth.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"

IUSE="+openssl -gnutls"

RDEPEND=">=dev-libs/glib-2.4
    gnutls? ( >=net-libs/gnutls-1.4.0 )
	openssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/gtk-doc-am-1
	dev-util/gtk-doc"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	use openssl && {
		use gnutls && 
			eerror "openssl and gnutls USE flags are mutually exclusive" || 
				c="--with-ssl=openssl $c"
	} || use gnutls || c="--with-ssl=no $c"

	# kludging around
	sed -i '/#ifndef HAVE_STRNDUP/i#define HAVE_STRNDUP' loudmouth/asyncns.c

	./autogen.sh
	econf $c
	sed -i 's/-Werror//' loudmouth/Makefile
	emake
}

src_install() {
	einstall
}

