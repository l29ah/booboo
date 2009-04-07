inherit subversion
DESCRIPTION=""
HOMEPAGE="http://goldendict.berlios.de"
SRC_URI=""
ESVN_REPO_URI="svn://svn.berlios.de/goldendict/trunk/src"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=x11-libs/qt-4.5
		>=x11-libs/qt-gui-4.5
		>=x11-libs/qt-webkit-4.5"
RDEPEND="dev-libs/libzip
		media-libs/libvorbis"
		

src_compile()
{
	qmake || die "eqmake4 failed"
	make  || die "make failed"

}
src_install() 
{
	dobin goldendict
#	newicon icons/programicon.png ${PN}.png
#	make_desktop_entry ${PN} GoldenDict ${PN}.png "Qt;Utility;Dictionary;"
}

