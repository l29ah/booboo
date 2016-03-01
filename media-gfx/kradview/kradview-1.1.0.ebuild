# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit kde-functions

DESCRIPTION="a viewer of images obtained for some different sources: X-ray, NMR and all DICOM-compatible imaging devices. Its aim is to be a complete platform for medical imaging and image processing."
HOMEPAGE="https://sourceforge.net/projects/kradview/"
SRC_URI="ftp://ftp.uk.freesbie.org/sites/distfiles.finkmirrors.net/sha1/ee4053c1e1b233cfe50ed4675713d6e146359cae/kradview-1.1.0.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="arts"

need-kde 3.5

src_configure() {
	econf "$(use_with arts)"
}
