DESCRIPTION="Collection of dicts for stardict."
HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_ja.php"
SRC_URI="http://dump.bitcheese.net/files/ixetumi/stardict-edict-2.4.2.tar.bz2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
DEPEND="|| ( app-text/sdcv app-dicts/stardict app-dicts/qstardict )"
RDEPEND=""
IUSE=""

src_prepare()
{
	unpack "$P.tar.bz2" 
}
src_install() 
{
	dodir /usr/share/stardict/dic
	insinto  /usr/share/stardict/dic
	doins -r *	
}

