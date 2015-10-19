# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/lighttpd/lighttpd-1.4.20.ebuild,v 1.8 2009/02/03 12:46:51 betelgeuse Exp $

EAPI=5

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit user eutils autotools depend.php git-r3

DESCRIPTION="Lightweight high-performance web server"
HOMEPAGE="http://www.lighttpd.net/"
EGIT_REPO_URI="git://git.lighttpd.net/lighttpd/lighttpd2.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE="bzip2 doc fastcgi gdbm ipv6 ldap lua minimal memcache mysql postgres pcre php rrdtool ssl test webdav xattr"

# cherokee block should be resolved properly
# http://bugs.gentoo.org/show_bug.cgi?id=224781
RDEPEND="
	!www-servers/cherokee
	>=sys-libs/zlib-1.1
	bzip2?    ( app-arch/bzip2 )
	gdbm?     ( sys-libs/gdbm )
	ldap?     ( >=net-nds/openldap-2.1.26 )
	lua?      ( >=dev-lang/lua-5.1 )
	memcache? ( dev-libs/libmemcache )
	mysql?    ( >=virtual/mysql-4.0 )
	postgres? ( >=dev-db/libpq-8.0 )
	pcre?     ( >=dev-libs/libpcre-3.1 )
	php?      (
		virtual/httpd-php
		!net-www/spawn-fcgi
	)
	rrdtool? ( net-analyzer/rrdtool )
	ssl?    ( >=dev-libs/openssl-0.9.7 )
	webdav? (
		dev-libs/libxml2
		>=dev-db/sqlite-3
		sys-fs/e2fsprogs
	)
	xattr? ( kernel_linux? ( sys-apps/attr ) )"

DEPEND="${RDEPEND}
	doc?  ( dev-python/docutils )
	test? (
		virtual/perl-Test-Harness
		dev-libs/fcgi
	)"

# update certain parts of lighttpd.conf based on conditionals
update_config() {
	local config="/etc/lighttpd/lighttpd.conf"

	# enable php/mod_fastcgi settings
	use php && \
		dosed 's|#.*\(include.*fastcgi.*$\)|\1|' ${config}
}

# remove non-essential stuff (for USE=minimal)
remove_non_essential() {
	local libdir="${D}/usr/$(get_libdir)/${PN}"

	# text docs
	use doc || rm -fr "${D}"/usr/share/doc/${PF}/txt

	# non-essential modules
	rm -f \
		${libdir}/mod_{compress,evhost,expire,proxy_backend_ajp13,proxy_backend_http,proxy_backend_scgi,secdownload,simple_vhost,status,setenv,trigger*,usertrack}.*

	# allow users to keep some based on USE flags
	use pcre    || rm -f ${libdir}/mod_{ssi,re{direct,write}}.*
	use webdav  || rm -f ${libdir}/mod_webdav.*
	use mysql   || rm -f ${libdir}/mod_mysql_vhost.*
	use lua     || rm -f ${libdir}/mod_{cml,magnet}.*
	use rrdtool || rm -f ${libdir}/mod_rrdtool.*

	if ! use fastcgi ; then
		rm -f ${libdir}/mod_proxy_backend_fastcgi.* ${libdir}/mod_proxy_core.* ${D}/usr/bin/spawn-fcgi \
			${D}/usr/share/man/man1/spawn-fcgi.*
	fi
}

pkg_setup() {
	if ! use pcre ; then
		ewarn "It is highly recommended that you build ${PN}"
		ewarn "with perl regular expressions support via USE=pcre."
		ewarn "Otherwise you lose support for some core options such"
		ewarn "as conditionals and modules such as mod_re{write,direct}"
		ewarn "and mod_ssi."
		ebeep 5
	fi

	use php && require_php_with_use cgi

	enewgroup lighttpd
	enewuser lighttpd -1 -1 /var/www/localhost/htdocs lighttpd
}

src_prepare() {
	# dev-python/docutils installs rst2html.py not rst2html
	sed -i -e 's|\(rst2html\)|\1.py|g' doc/Makefile.am || \
		die "sed doc/Makefile.am failed"

	# typo in src dist.
	sed -i -e 's|postgresvhost|postgresqlvhost|g' doc/Makefile.am || \
		die "sed doc/Makefile.am failed"

	eautoreconf || die
}

src_compile() {
	econf --libdir=/usr/$(get_libdir)/${PN} \
		--enable-lfs \
		$(use_enable ipv6) \
		$(use_with bzip2) \
		$(use_with gdbm) \
		$(use_with lua) \
		$(use_with ldap) \
		$(use_with memcache) \
		$(use_with mysql) \
		$(use_with pcre) \
		$(use_with postgres postgresql) \
		$(use_with ssl openssl) \
		$(use_with webdav webdav-props) \
		$(use_with webdav webdav-locks) \
		$(use_with xattr attr) \
		|| die "econf failed"

	emake || die "emake failed"

	if use doc ; then
		einfo "Building HTML documentation"
		cd doc
		emake html || die "failed to build HTML documentation"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# init script stuff
	newinitd "${FILESDIR}"/lighttpd.initd-1.4.13-r3 lighttpd || die
	newconfd "${FILESDIR}"/lighttpd.confd lighttpd || die

	if use php || use fastcgi ; then
		newinitd "${FILESDIR}"/spawn-fcgi.initd spawn-fcgi || die
		newconfd "${FILESDIR}"/spawn-fcgi.confd spawn-fcgi || die
	fi

	# configs
	insinto /etc/lighttpd
	newins "${FILESDIR}"/conf/lighttpd.conf-1.5.0 lighttpd.conf
	doins "${FILESDIR}"/conf/mime-types.conf
	doins "${FILESDIR}"/conf/mod_cgi.conf
	newins "${FILESDIR}"/conf/mod_proxy_core.conf-1.5.0 mod_proxy_core.conf

	# Secure directory for fastcgi sockets
	keepdir /var/run/lighttpd/
	fperms 0750 /var/run/lighttpd/
	fowners lighttpd:lighttpd /var/run/lighttpd/

	# update lighttpd.conf directives based on conditionals
	update_config

	# docs
	dodoc -r contrib

	use doc && dohtml -r doc/*

	# logrotate
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/lighttpd.logrotate lighttpd || die

	keepdir /var/l{ib,og}/lighttpd /var/www/localhost/htdocs
	fowners lighttpd:lighttpd /var/l{ib,og}/lighttpd
	fperms 0750 /var/l{ib,og}/lighttpd

	use minimal && remove_non_essential
}

pkg_postinst () {
	echo
	if [[ -f ${ROOT}etc/conf.d/spawn-fcgi.conf ]] ; then
		einfo "spawn-fcgi is now included with lighttpd"
		einfo "spawn-fcgi's init script configuration is now located"
		einfo "at /etc/conf.d/spawn-fcgi."
		echo
	fi

	if use fastcgi ; then
		ewarn "As of lighttpd-1.5.0, mod_fastcgi has been replaced by mod_proxy_core."
		ewarn "Please migrate your existing configuration."
		ebeep 5
	fi

	echo
}
