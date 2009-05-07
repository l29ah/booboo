inherit git

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://www.loudmouth-project.org/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/engineyard/loudmouth.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"

IUSE=""

RDEPEND=">=dev-libs/glib-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/gtk-doc-am-1
	dev-util/gtk-doc"

DOCS="AUTHORS ChangeLog NEWS README"

src_compile() {
	./autogen.sh
	econf
	emake
}

src_install() {
	einstall
}

