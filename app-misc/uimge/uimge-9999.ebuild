inherit eutils git

DESCRIPTION="console application to post you pictures into web"
HOMEPAGE="http://uimge.googlecode.com"
SRC_URI=""
EGIT_REPO_URI="git://github.com/Apkawa/uimge.git"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

src_install()
{
	ls
	cd "${WORK_DIR}"uimgepy
	dodir /usr/lib/python2.6/site-packages/uimge || die "dodir uimge failed"
		insinto /usr/lib/python2.6/site-packages/uimge
		doins -r uimge/* || die "doins uimge failed"
			fperms +x /usr/lib/python2.6/site-packages/uimge/uimge.py || die "fperms py failed"
			fperms +x /usr/lib/python2.6/site-packages/uimge/uimge.pyc # || die "fperms pyc failed"
		dosym /usr/lib/python2.6/site-packages/uimge/uimge.py /usr/bin/uimge

	dodir /usr/share/locale/ru/LC_MESSAGES
		insinto /usr/share/locale/ru/LC_MESSAGES
		doins locale/ru/LC_MESSAGES/uimge.mo || die "doins locale failed"
}
