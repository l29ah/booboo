# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit perl-module

DESCRIPTION="LftpFS is FUSE filesystem with caching for smart mirror of sites.
Useful for mirroring of Linux repositories. It's based on LFTP client, which
supports FTP, HTTP, FISH, SFTP, HTTPS, FTPS protocols and works over proxies."
HOMEPAGE="http://sourceforge.net/projects/lftpfs/"
SRC_URI="http://sunet.dl.sourceforge.net/project/lftpfs/lftpfs/lftpfs-0.4.2/lftpfs-0.4.2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="dev-lang/perl[ithreads]"
RDEPEND="sys-fs/fuse
	net-ftp/lftp
	dev-perl/Fuse
	perl-core/Time-HiRes
	dev-perl/IPC-Run"
