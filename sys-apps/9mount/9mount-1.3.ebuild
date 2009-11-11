DESCRIPTION="A set of SUID mounting tools for use with v9fs."
HOMEPAGE="http://sqweek.dnsdojo.org/code/9mount/"
SRC_URI="http://sqweek.dnsdojo.org/9p/${P}.tar.gz"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~x86 ~amd64"

src_compile() {
	sed -i -e 's|prefix=.*|prefix='${D}/${ROOT}/usr'|' Makefile
	make
}

src_install() {
	make install
}
