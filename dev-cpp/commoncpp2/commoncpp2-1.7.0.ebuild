# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/commoncpp2/commoncpp2-1.7.0.ebuild,v 1.1 2009/01/02 20:00:00 dev-zero Exp $

inherit eutils autotools

if [[ ${PV} == *9999* ]]
then
	inherit subversion
	ESVN_REPO_URI="svn://svn.sv.gnu.org/commoncpp/trunk/commoncpp2"
else
	SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"
fi

DESCRIPTION="GNU Common C++ is a C++ framework offering portable support for threading, sockets, file access, daemons, persistence, serial I/O, XML parsing, and system services"
#SRC_URI="mirror://gnu/commoncpp/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/commoncpp/ http://svn.savannah.gnu.org/viewvc/trunk/commoncpp2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug doc examples ipv6 gnutls sources"

RDEPEND="gnutls? ( dev-libs/libgcrypt
		net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )
	sys-libs/zlib"
DEPEND="doc? ( >=app-doc/doxygen-1.3.6 )
	${RDEPEND}"

src_unpack() {
	if [[ ${PV} == *9999* ]]
	then
		subversion_src_unpack
	else
		unpack ${A}
	fi

	cd "${S}"

	epatch "${FILESDIR}/1.6.1-gcc42_atomicity.patch" \
		"${FILESDIR}/9999-configure_detect_netfilter.patch"
	#	"${FILESDIR}/${PV}-autoconf.patch"

	# temporary fix 'src/nat.cpp'
	#sed -i -e 's/^char \* natErrorString/const char \* natErrorString/' src/nat.cpp || die "sed failed"
	sed -i 's/^char \* natErrorString/const char \* natErrorString/' src/nat.cpp || die "sed failed"

	#m4_pattern_allow([^LT_VERSION$])
	# insere a linha anterior antes de VERSION no configure.ac
	sed -i '/^VERSION=/i\
		m4_pattern_allow([^LT_VERSION$])' configure.ac

	AT_M4DIR="m4" eautoreconf
}

src_compile() {
#	use doc || \
#		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure || die "sed failed"

	if use doc ; then
		# To get the best results for PDF output you should
		# set the PDF_HYPERLINKS and USE_PDFLATEX tags to YES.
		#  In this case the Makefile will only contain a
		#  target to build refman.pdf directly.
		sed -i "s/^PDF_HYPERLINKS.*/PDF_HYPERLINKS=yes/" doc/Doxyfile.in || die "sed failed"
		sed -i "s/^USE_PDFLATEX.*/USE_PDFLATEX=yes/" doc/Doxyfile.in || die "sed failed"
	else
		sed -i "s/^DOXYGEN=.*/DOXYGEN=no/" configure || die "sed failed"
	fi


	local myconf
	use gnutls || myconf="--with-openssl"

	econf \
		$(use_enable debug) \
		$(use_with ipv6 ) \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS NEWS ChangeLog README THANKS TODO COPYING.addendum

	#  --docdir=DIR            documentation root [DATAROOTDIR/doc/PACKAGE]
	#  --htmldir=DIR           html documentation [DOCDIR]
	#  --dvidir=DIR            dvi documentation [DOCDIR]
	#  --pdfdir=DIR            pdf documentation [DOCDIR]
	#  --psdir=DIR             ps documentation [DOCDIR]

	# Only install html docs
	# man and latex available, but seems a little wasteful
	use doc && dohtml doc/html/*

	if use examples ; then
		insinto /usr/share/doc/${PF}/examples
		#cd demo
		#doins *.cpp *.h *.xml README
		doins demo/*
	fi

	if use sources ; then
		insinto /usr/share/doc/${PF}/sources
		#cd src
		#doins *.cpp *.h *.c
		doins src/*
	fi
}

#pkg_postinst() {
#	ewarn "There's a change in the ABI between version 1.5.x and 1.6.x, please"
#	ewarn "run the following command to find broken packages and rebuild them:"
#	ewarn "    revdep-rebuild --library=libccext2-1.5.so"
#}

# Some of the tests hang forever
#src_test() {
#	cd "${S}/tests"
#	emake || die "emake tests failed"
#	./test.sh || die "tests failed"
#}

