EAPI=8

DESCRIPTION="Collection of dicts for stardict."
HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="http://download.huzheng.org/ja/stardict-jredict-2.4.2.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="|| ( app-text/sdcv app-dicts/stardict app-dicts/qstardict )"
RDEPEND=""
IUSE=""

src_install()
{
	dodir /usr/share/stardict/dic
	insinto  /usr/share/stardict/dic
	doins -r *	
}

