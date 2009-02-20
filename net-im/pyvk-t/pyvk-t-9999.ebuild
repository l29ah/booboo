# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pyicq-t/pyicq-t-0.8.1.ebuild,v 1.1 2008/12/19 18:00:44 griffon26 Exp $

NEED_PYTHON=2.3

inherit eutils multilib python subversion 

#MY_P="${P/pyicq-t/pyicqt}"

DESCRIPTION="Python based jabber transport for vkontakte.ru"
HOMEPAGE="http://code.google.com/p/pyvk-t/"
#SRC_URI="http://pyicqt.googlecode.com/files/${MY_P}.tar.gz"
#S="${WORKDIR}/${MY_P}"
#ESVN_REPO_URI="http://pyicqt.googlecode.com/svn/trunk"
#EGIT_REPO_URI="git://gitorious.org/pyicqt/mainline.git"
#EGIT_BRANCH="unstable"
ESVN_REPO_URI="http://pyvk-t.googlecode.com/svn/trunk/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="net-im/jabber-base
net-im/pyxmpp
dev-python/beautifulsoup
dev-python/demjson"
RDEPEND="${DEPEND}"
#	>=dev-python/twisted-2.2.0
#	>=dev-python/twisted-words-0.1.0
#	>=dev-python/twisted-web-0.5.0
#	webinterface? ( >=dev-python/nevow-0.4.1 )
#	>=dev-python/imaging-1.1"

#src_unpack() {
#	unpack ${A} && cd "${S}" || die "unpack failed"
#}

src_install() {
	local inspath

	python_version
	inspath=/usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
	insinto ${inspath}
	doins * || die
#	doins -r data src tools
#	newins PyICQt.py ${PN}.py

#	insinto /etc/jabber
#	newins config_example.xml ${PN}.xml
#	fperms 600 /etc/jabber/${PN}.xml
#	fowners jabber:jabber /etc/jabber/${PN}.xml
#	dosed \
#		"s:<spooldir>[^\<]*</spooldir>:<spooldir>/var/spool/jabber</spooldir>:" \
#		/etc/jabber/${PN}.xml
#	dosed \
#		"s:<pid>[^\<]*</pid>:<pid>/var/run/jabber/${PN}.pid</pid>:" \
#		/etc/jabber/${PN}.xml

#	newinitd "${FILESDIR}/${PN}-0.8-initd" ${PN}
#	dosed "s:INSPATH:${inspath}:" /etc/init.d/${PN}
}

pkg_postinst() {
	python_version
	python_mod_optimize /usr/$(get_libdir)/python${PYVER}/site-packages/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/python*/site-packages/${PN}
}
