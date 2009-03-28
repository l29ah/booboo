EAPI=2

EGCLIENT_REPO_URI="http://src.chromium.org/svn/trunk/src/"
EGCLIENT_CONFIG="${FILESDIR}/.gclient"


inherit gclient
RESTRICT="mirror"


DESCRIPTION="Chromium is the open-source project behind Google Chrome."
HOMEPAGE="http://dev.chromium.org/"
SRC_URI=""		# TODO: tarball builds
#ESVN_REPO_URI="http://src.chromium.org/svn/trunk/src"
# TODO: not to download lots of junk lying around in trunk/src/
# like third-party sources and test suites

LICENSE="BSD" #mb gpl-2?
SLOT="live"
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

src_compile() {

	cd ${S}/chrome

	scons --mode=opt --site-dir=../site_scons ${MAKEOPTS} chrome || die "scons build failed"
}

src_install() {
	cd ${S}/chrome/Hammer

	dodir /opt/chromium
	dodir /opt/chromium/locales
	dodir /opt/chromium/themes
	insinto /opt/chromium
	for file in $(find | sed '/opt/d;/\.$/d;/themes/d;/chrome$/d;/locales/d;s/\.\///'); do
		doins ${file} || die "doins failed"
	done

	insinto /opt/chromium/locales
	doins -r locales/*
	
	insinto /opt/chromium/themes
	doins -r themes/*

	exeinto /opt/chromium
	doexe chrome
	dosym /opt/chromium/chrome /opt/bin/chromium
}
