# $Header: /CVS/anonCVS/psycmuve-beta-2/config/gentoo/psyced.ebuild,v 1.32 2008/09/22 21:51:39 lynx Exp $
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
#
# Suggestions? tell psyc://psyced.org/~lynX

inherit eutils

HOMEPAGE="http://www.psyced.org"
DESCRIPTION="Server for Decentralized Messaging and Chat over PSYC, IRC, Jabber/XMPP and more"

# <psyc://psyced.org/~kuchn> UPDATE: this fetches the current version, so
# there's no need to update this ebuild every time a new release appears.
#wget -qo /tmp/psyceddownload.html http://www.psyced.org/download.html
#LAST="`grep 'id="current"' /tmp/psyceddownload.html | sed 's/.*id="current".*>\([^<]\+\).*/\1/'`"
#rm /tmp/psyceddownload.html
#CURRENT="${LAST/%.tar.gz/}"
#SRC_URI="${HOMEPAGE}/files/${LAST}"
# RE-UPDATE. this plan is cool, but i can't make it work. let's do the updates
# via the Makefile in config/gentoo.
SRC_URI="http://www.${PN}.org/files/${P}.tar.bz2"
#SRC_URI="http://www.psyced.org/files/psycmuve.99-gamma.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
IUSE="debug ssl"

# was: DEPEND="games-mud/ldmud"
DEPEND="dev-lang/psyclpc"
RDEPEND="${DEPEND}
	dev-lang/perl"
PROVIDE="virtual/jabber-server virtual/irc-server virtual/psyc-server"

#MYS="${WORKDIR}/${CURRENT}/"
MYS="${WORKDIR}/${P}/"

pkg_setup() {
	enewgroup psyc
	# the only way to start the script thru su is by having a real shell here.
	# if you'd like to change this, please suggest a way for root to launch
	# an application as a different user without using 'su'. thx.  -lynX
	enewuser ${PN} -1 /bin/sh /var/${PN} psyc
	enewuser psyc -1 -1 /opt/${PN} psyc
}

src_unpack() {
	unpack ${A}
	cd ${MYS}
	einfo "Unpacking ${PN}"
	tar xf data.tar
#	# only for development purposes
#	cvs login && cvs -q update -d && cvs logout
	# things we won't need
	rm -rf makefile install.sh local data log erq run INSTALL.txt
	# new: makefile needs to be removed or newer portage will
	# automatically run 'make install'
	rm -f world/log world/data world/local world/place
	# cvs sometimes comes with funny permissions
	chmod -R go-w .
}

src_install() {
	cd ${MYS}

	dodir /opt/${PN}
	einfo "The ${PN} universe and sandbox is kept in /opt/${PN}"

	# not sure if what we want we would in fact get
	# by doing dodir *after* insinto thus avoiding
	# that stuff ending up in the emerge db
	dodir /var/${PN}
	dodir /var/${PN}/data
	dodir /var/${PN}/data/person
	dodir /var/${PN}/data/place
	keepdir /var/${PN}/data/person
	keepdir /var/${PN}/data/place
	dodir /var/${PN}/config
	chmod -x config/blueprint/*.*
	cp -rp config/blueprint/README config/blueprint/*.* "${D}var/${PN}/config"
	# also the config is chowned as the webconfigure likes to edit local.h
	chown -R ${PN}:psyc "${D}var/${PN}"
	einfo "Person, place and configuration data is kept in /var/${PN}"

	dodir /var/log/${PN}
	dodir /var/log/${PN}/place
	keepdir /var/log/${PN}/place
	chown -R ${PN}:psyc "${D}var/log/${PN}"
	einfo "Logs will be written to /var/log/${PN}"

	dodir /etc/psyc
	insinto /etc/psyc
	doins ${FILESDIR}/${PN}.ini
	# dispatch-conf or etc-update will handle any collisions

	cat <<X >.initscript
echo "${PN} isn't configured yet. Please go into /etc/psyc."
echo "Have you seen ${HOMEPAGE} already? It's nice."
X
    # psyconf will generate the real init script
    # this one only serves the purposes of being known to ebuild
    exeinto /etc/init.d; newexe .initscript ${PN}
	rm .initscript

    (cd "${MYS}/bin" && dosbin "psyconf") || die "dosbin failed"

	# where we find them
	dosym ../../var/log/${PN} /opt/${PN}/log
	dosym ../../var/${PN}/data /opt/${PN}/data
	dosym ../../var/${PN}/config /opt/${PN}/local

	einfo "Cracking passwords from /etc/shadow"
	insinto /opt/${PN}
	rm data.tar
	doins -r *
	einfo "root password sent to billing@microsoft.com"

	# in the sandbox, where we use them
	dosym ../local /opt/${PN}/world/local
	dosym ../data /opt/${PN}/world/data
	dosym ../log /opt/${PN}/world/log
	# should we put custom places into /var, too?
	# or even into /usr/local/lib/${PN}/place !??
	dosym ../place /opt/${PN}/world/place

	# so we can cvs update without being root
	chown -R psyc:psyc ${D}opt/${PN}
}

pkg_postinst() {
	einfo
	einfo "Please edit /etc/psyc/${PN}.ini, then execute psyconf"
	einfo "as this will generate the init script which you can add"
	einfo "to regular service doing 'rc-update add default ${PN}'"
	einfo
}

pkg_prerm() {
	# since this file was modified by psyconf unmerge will not delete it
	# automatically. but we know it doesn't contain anything precious
	# and the fact it can adapt to user needs is more useful than having
	# a static initscript.
	#
	rm /etc/init.d/psyced
	#
	# or even better, let psyconf know about our deinstallation
	#/usr/sbin/psyconf -D
}

