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
	dodir /usr/share/pyvk-t 
	insinto /usr/share/pyvk-t
	doins -r *
	fperms +x /usr/share/pyvk-t/pyvkt_new.tac
	dobin "${FILESDIR}""/pyvk"
}
pkg_postinst()
{
einfo 'Now edit /usr/share/pyvk-t/pyvk-t_new.cfg'
einfo 'For more information visit http://code.google.com/p/pyvk-t/wiki/LittleHelp'
einfo 'twistd -y pyvkt_new.tac -l <logfile>'
}

