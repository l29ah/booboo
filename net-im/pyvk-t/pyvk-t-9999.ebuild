# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit subversion
DESCRIPTION="Python based jabber transport for vkontakte.ru"
HOMEPAGE="http://code.google.com/p/pyvk-t/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="=dev-lang/python-2.5*
		dev-python/beautifulsoup
		dev-python/twisted-words
		dev-db/mysql
		dev-python/demjson
		net-im/ejabberd
		dev-python/mysql-python"
RDEPEND="${DEPEND}"

ESVN_REPO_URI="http://pyvk-t.googlecode.com/svn/trunk/"

src_install()
{
	local inspath
	python_version
	inspath=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	insinto ${inspath}
	doins -r * || die "doins failed"
	newinitd "${FILESDIR}/initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}

}
pkg_postinst()
{
einfo
einfo 'Now edit '/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}'/pyvk-t_new.cfg'
einfo
einfo 'Then run /etc/init.d/'${PN} 'start'
einfo
}

