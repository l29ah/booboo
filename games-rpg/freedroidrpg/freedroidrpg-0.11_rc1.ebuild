inherit eutils games

DESCRIPTION="Save post-war earth from rebel bots in a Diablo-style RPG"
HOMEPAGE="http://freedroid.sourceforge.net/"
SRC_URI="mirror://sourceforge/freedroid/${P/_/}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls vorbis"

S="${WORKDIR}/${P/_/}"

RDEPEND=">=media-libs/libsdl-1.2.3
	media-libs/jpeg
	sys-libs/zlib
	media-libs/libpng
	media-libs/sdl-image
	media-libs/sdl-net
	media-libs/sdl-mixer
	vorbis? ( media-libs/libogg )
	vorbis? ( media-libs/libvorbis )
	x11-libs/libX11
	virtual/opengl"
DEPEND="${RDEPEND}
	x11-libs/libXt"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find sound graphics -type f -print0 | xargs -0 chmod a-x
}

src_compile() {
	egamesconf \
		$(use_enable nls) \
		$(use_enable vorbis) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -f "${D}/${GAMES_BINDIR}/"{croppy,pngtoico}
	doicon graphics/paraicon.bmp
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog HELP_WANTED INSTALL INSTALL.generic NEWS README
	make_desktop_entry freedroidRPG "Freedroid RPG" /usr/share/pixmaps/paraicon.bmp
	prepgamesdirs
}
