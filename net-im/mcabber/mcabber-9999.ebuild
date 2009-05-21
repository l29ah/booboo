inherit mercurial
DESCRIPTION="A small Jabber console client with various features, like MUC, SSL, PGP"
HOMEPAGE="http://www.lilotux.net/~mikael/mcabber/"
EHG_REPO_URI="http://www.lilotux.net/~mikael/mcabber/hg/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~mips ~ppc ~ppc64 ~sparc x86"

IUSE="crypt otr spell ssl patch version"

LANGS="de en fr nl pl uk ru"
# localized help versions are installed only, when LINGUAS var is set
for i in ${LANGS}; do
	IUSE="${IUSE} linguas_${i}"
done;

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.7-r1 )
	crypt? ( >=app-crypt/gpgme-1.0.0 )
	otr? ( >=net-libs/libotr-3.1.0 )
	spell? ( app-text/aspell )
	>=dev-libs/glib-2.0.0
	sys-libs/ncurses
	net-libs/libotr
	"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	cd hg/mcabber
	use patch && epatch "${FILESDIR}""/dbus.patch" || die
	use patch && epatch "${FILESDIR}""/easy.patch" || die "patch failed"
	./autogen.sh
	econf \
		$(use_enable crypt gpgme) \
		$(use_enable otr) \
		$(use_enable spell aspell) \
		$(use_with ssl) \
		use version --enable-hgcset \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	cd hg/mcabber
	make install DESTDIR="${D}" || die "make install failed"
	# clean unneeded language documentation
	for i in ${LANGS}; do
		! use linguas_${i} && rm -rf "${D}"/usr/share/${PN}/help/${i}
	done

	dodoc AUTHORS ChangeLog NEWS README TODO mcabberrc.example
	dodoc doc/README_PGP.txt

	# contrib themes
	insinto /usr/share/${PN}/themes
	doins "${WORKDIR}"/hg/mcabber/contrib/themes/*

	# contrib generic scripts
	exeinto /usr/share/${PN}/scripts
	doexe "${WORKDIR}"/hg/mcabber/contrib/*.{pl,py,rb}

	# contrib event scripts
	exeinto /usr/share/${PN}/scripts/events
	doexe "${WORKDIR}"/hg/mcabber/contrib/events/*
}

pkg_postinst() {
	elog
	elog "MCabber requires you to create a subdirectory .mcabber in your home"
	elog "directory and to place a configuration file there."
	elog "An example mcabberrc was installed as part of the documentation."
	elog "To create a new mcabberrc based on the example mcabberrc, execute the"
	elog "following commands:"
	elog
	elog "  mkdir -p ~/.mcabber"
	elog "  bzcat ${ROOT}usr/share/doc/${PF}/mcabberrc.example.bz2 >~/.mcabber/mcabberrc"
	elog
	elog "Then edit ~/.mcabber/mcabberrc with your favorite editor."
	elog
	elog "As of MCabber version 0.8.2, there is also a wizard script"
	elog "with which you can create all necessary configuration options."
	elog "To use it, simply execute the following command (please note that you need"
	elog "to have dev-lang/ruby installed for it to work!):"
	elog
	elog "  ${ROOT}usr/share/${PN}/scripts/mcwizz.rb"
	elog
	elog
	elog "See the CONFIGURATION FILE and FILES sections of the mcabber"
	elog "manual page (section 1) for more information."
	elog
	elog "From version 0.9.0 on, MCabber supports PGP encryption of messages."
	elog "See README_PGP.txt for details."
	elog
	elog "Check out ${ROOT}usr/share/${PN} for contributed themes and event scripts."
	elog
}
