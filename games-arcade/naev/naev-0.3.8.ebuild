inherit games

DESCRIPTION="NAEV is 2d action/rpg space game that combines elements from the 
action, rpg and simulation genres."
HOMEPAGE="http://code.google.com/p/naev/"
SRC_URI="http://naev.googlecode.com/files/${P}.tar.bz2
	http://naev.googlecode.com/files/ndata-${PV}"
# the second stands for data.
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"

RDEPEND="dev-libs/libxml2
	media-libs/freetype
	media-libs/sdl-image
	media-libs/sdl-mixer
	virtual/opengl"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_unpack() 
{
	unpack ${P}.tar.bz2 || die
	cp "${DISTDIR}"/ndata-"${PV}" "${T}" || die
	cd "${S}" || die
	# use system png library.
#	sed -i \
#		-e "s:::" src/opengl.c || die "sed failed" 

	# fix make system
	epatch "${FILESDIR}/${PV}-Makefile.patch" || die
	cd ${T} && mv ndata-${PV} ndata
}

src_compile() 
{
	emake || die "emake failed"
	if use doc; then
		emake doc || die "emake doc failed"
	fi
}

src_install() 
{
	GAMES_DATADIR=/usr/local/games/
	dodir /usr/local/games/${PN}
	dogamesbin "${PN}" || die "dogamesbin failed"

	insinto "${GAMES_DATADIR}/${PN}"
	doins "${T}"/ndata || die "doins ndata falied"
	doins "${WORKDIR}"/"${P}"/conf.example || die "doins conf failed"
	prepgamesdirs
	
}
pkg_postinst()
{
	einfo "NAEV's game data locate in '"${GAMES_DATADIR}ndata"'"
	einfo "Create your own config like conf.example "

}
