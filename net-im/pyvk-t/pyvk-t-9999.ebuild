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
		|| ( net-im/ejabberd net-im/jabberd net-im/jabberd2	)
		dev-python/mysql-python"
RDEPEND="${DEPEND}"


ESVN_REPO_URI="http://pyvk-t.googlecode.com/svn/trunk/"

src_install()
{
	local inspath
	python_version
	inspath=/usr/lib/python2.5/site-packages/${PN}
	insinto ${inspath}
	doins -r * || die "doins failed"
	newinitd "${FILESDIR}/initd" ${PN}
	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}

}
pkg_postinst()
{
einfo 'You need to configure your MYSQL server'
einfo 'Add a MYSQL db. How-to you may read here'
einfo 'http://www.gentoo.org/doc/ru/mysql-howto.xml'
einfo 'Then add the MYSQL dump'
einfo 'cd /usr/lib/python2.5/site-packages/pyvk-t && mysql basename < pyvk-t_new.sql'
einfo 'Now edit /usr/lib/python2.5/site-packages/pyvk-t/pyvk-t_new.cfg'
einfo 'To start pyvk-t on local machine you need to configure ejabberd or jabberd'
einfo 'Now you can start it only from user. To run write this'
einfo 'twistd -y pyvkt_new.tac -l <logfile> or twistd -y pyvkt_new.tac -n'
einfo 'You may try to use "chmod -R -h user:user /usr/lib/python2.5/site-packages/pyvk-t"'
}

