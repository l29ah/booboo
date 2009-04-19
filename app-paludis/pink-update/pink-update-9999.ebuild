DESCRIPTION="paludis port of etc-update"
HOMEPAGE=""
#SRC_URI="http://l29ah.wtf.la/kawaii/pink-update"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-shells/bash"
RDEPEND="${DEPEND}"
src_compile()
{
	cp "${FILESDIR}"/"${PN}" "${WORKDIR}" || die
	chmod +x "${WORKDIR}"/"${PN}" || die
}
src_install()
{
	dobin ${WORKDIR}/"${PN}" || die
}


