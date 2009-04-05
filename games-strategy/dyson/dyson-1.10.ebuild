inherit games

DESCRIPTION="Dyson is an ambient real-time strategy game with abstract visuals."
HOMEPAGE="http://www.dyson-game.com"
SRC_URI="http://www.dyson-game.com/files/dyson110-linux.zip"

LICENSE="freeware"
SLOT="0"
KEYWORDS="~x86 -amd64"
IUSE=""

DEPEND="
		dev-lang/mono
		dev-dotnet/libgdiplus
		media-libs/libsdl
		>=media-libs/sdl-mixer-1.2.6
		>=media-libs/sdl-image-1.2.4
		>=media-libs/sdl-ttf-2.0.7
		>=media-libs/sdl-gfx-2.0.13
		>=media-libs/smpeg-0.4.4

		media-libs/libvorbis
		media-libs/libpng
		app-arch/unzip
		"
RDEPEND="${DEPEND}"

src_unpack()
{
	unpack "dyson110-linux.zip"
}
src_install()
{
	mkdir /opt/dyson
	insinto /opt/dyson
	doins -r *
	fperms +x /opt/dyson/run-dyson
	dobin /opt/dyson/run-dyson
}
pkg_postinst()
{
	einfo "FAQ: http://www.dyson-game.com/blog/?page_id=9"
}
