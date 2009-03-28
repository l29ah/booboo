EAPI=2

ESVN_REPO_URI="http://gclient.googlecode.com/svn/trunk/gclient"

inherit subversion

RESTRICT="mirror"

DESCRIPTION="gclient is a tool for managing a modular checkout of source code
from multiple source code repositories."
HOMEPAGE="http://code.google.com/p/gclient/"

SRC_URI=""

LICENSE="GPL-2"
SLOT="live"
KEYWORDS="~x86 ~amd64"

IUSE=""

DEPEND="dev-python/pymox"
RDEPEND="${DEPEND}"

src_install() {
	dobin gclient.py
	dobin gclient_test.py
}
