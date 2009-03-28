inherit subversion

DESCRIPTION="Chromium is the open-source project behind Google Chrome."
HOMEPAGE="http://dev.chromium.org/"
SRC_URI=""		# TODO: tarball builds
ESVN_REPO_URI="http://src.chromium.org/svn/trunk/src"
# TODO: not to download lots of junk lying around in trunk/src/
# like third-party sources and test suites

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 x86"	# Warning: no amd64 support!?
IUSE="debug"

# Info from http://code.google.com/p/chromium/wiki/LinuxBuildInstructionsPrerequisites
# TODO: need Hammer (WTF is this!?)
DEPEND=">=dev-lang/python-2.4.0
		>=dev-lang/perl-5.0.0
		>=sys-devel/gcc-4.2.0
		>=sys-devel/bison-2.3
		>=sys-devel/flex-2.5.34
		>=dev-util/gperf-3.0.3
		>=dev-libs/nss-3.12.0
		>=dev-libs/nspr-4.7.1
		media-fonts/corefonts
		>=dev-util/pkgconfig-0.20
		dev-util/scons"
RDEPEND="${DEPEND}"

src_unpack() {
		subversion_src_unpack
		cd "${S}"		
}

src_compile() {
		cd "${S}"/src/chrome
		if use debug; then
			hammer
		else
			hammer chrome
		fi
}

# TODO: saner install paths
src_install() {
		dobin "${S}"/src/chrome/Hammer/*
}

