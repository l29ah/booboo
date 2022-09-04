EAPI=8

DESCRIPTION="Collection of dicts for stardict."
HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="https://src.fedoraproject.org/repo/pkgs/stardict-dic/stardict-edict-2.4.2.tar.bz2/0aa46b7d589a01663c3fb465152db85d/stardict-edict-2.4.2.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="|| ( app-text/sdcv app-dicts/stardict app-dicts/qstardict )"
RDEPEND=""
IUSE=""

src_install() {
	dodir /usr/share/stardict/dic
	insinto  /usr/share/stardict/dic
	doins -r *	
}

