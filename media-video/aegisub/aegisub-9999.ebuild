EAPI="2"
WX_GTK_VER="2.8"
inherit eutils subversion wxwidgets

DESCRIPTION="Advanced SSA/ASS subtitle editor"
HOMEPAGE="http://malakith.net/aegiwiki/Main_Page"

ESVN_REPO_URI="http://svn.aegisub.net/trunk/aegisub"
#ESVN_PROJECT="aegisub"
EAPI="2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa debug +ffmpeg lua openal perl pulseaudio spell ruby"

RDEPEND="=x11-libs/wxGTK-2.8*[opengl]
	media-libs/libass
	media-libs/fontconfig
	media-libs/freetype

	alsa? (	media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )
	openal? ( media-libs/openal )

	perl? ( dev-lang/perl )
	ruby? ( dev-lang/ruby )
	lua? ( dev-lang/lua )

	spell? ( app-text/hunspell )
	ffmpeg? ( media-video/ffmpeg )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	media-gfx/imagemagick
	dev-libs/glib"

pkg_setup() {
	if ! built_with_use x11-libs/wxGTK opengl; then
		eerror "Aegisub needs wxGTK with opengl support. Please recompile wxGTK:"
		eerror "echo \"=x11-libs/wxGTK opengl\" >> /etc/portage/package.use"
		eerror "emerge -av1 wxGTK"
		die "wxGTK not compiled with 'opengl'!"
	fi
}

src_configure() {
	echo 9999 > svn_revision

	epatch ${FILESDIR}/sandbox.patch || die

	local myconf
	myconf="--with-libass --prefix=/usr"
	
	use ffmpeg		&&	--with-provider-video=ffmpeg && \
						--with-provider-audio=ffmpeg	\
	use alsa		&&	--with-player-audio=alsa		\
	use openal		&&	--with-player-audio=openal		\
	use pulseaudio	&&	--with-player-audio=pulseaudio	\
	use portaudio	&&	--with-player-audio=portaudio	\

	cp ${FILESDIR}/*.m4 m4macros || die
	cp ${FILESDIR}/config* m4macros || die

	./autogen.sh ${myconf} || die "configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
