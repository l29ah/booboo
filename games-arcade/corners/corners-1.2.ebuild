inherit games eutils

DESCRIPTION="Logical game. Cornes. You have a desk 8*8..."
HOMEPAGE="https://sourceforge.net/projects/corners/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
src_unpack()
{
	unpack "corners-${PV}.tar.bz2"
}
src_compile()
{
	emake || die "emake failed"
}
src_install()
{
	DATADIR="/usr/local/games/${PN}"
	dodir "${DATADIR}" || die
	insinto "${DATADIR}" 
	doins -r corners locale corners.png corners-no-bg.png || die "doins failed"
	fperms +x  "${DATADIR}"/"${PN}" || die "fperms failed"

	dogamesbin "${DATADIR}"/"${PN}" || die "dobin failed"
}
