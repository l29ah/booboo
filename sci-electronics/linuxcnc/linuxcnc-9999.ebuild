# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="tk(+)"

inherit git-r3 eutils autotools-utils python-single-r1

DESCRIPTION="LinuxCNC controls CNC machines."
HOMEPAGE="http://linuxcnc.org/"
EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+uspace +X +gtk gnome gstreamer modbus usb"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	virtual/libudev
	sys-libs/ncurses
	sys-libs/readline
	sys-devel/gettext
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tclx
	dev-tcltk/tkimg
	dev-tcltk/tclreadline
	dev-tcltk/blt
	dev-tcltk/bwidget
	${PYTHON_DEPS}
	dev-lang/python:2.7[tk]
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-python/pillow[tk,${PYTHON_USEDEP}]
	dev-libs/boost[python,${PYTHON_USEDEP}]
	modbus? (
		dev-libs/libmodbus
	)
	usb? (
		virtual/libusb
	)
	media-libs/mesa
	x11-apps/mesa-progs
	X? (
		x11-libs/libXaw
		dev-python/python-xlib[${PYTHON_USEDEP}]
	)
	gtk? (
		x11-libs/gtk+:2
		dev-python/pygtk[${PYTHON_USEDEP}]
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/pygtkglext[${PYTHON_USEDEP}]
		dev-python/pygtksourceview[${PYTHON_USEDEP}]
	)
	gnome? (
		dev-python/gnome-python-base
		dev-util/glade[python]
		gnome-base/libgnomeprintui
	)
	gstreamer? (
		dev-python/gst-python:1.0
		media-libs/gst-plugins-base:1.0
	)
	|| (
		net-analyzer/netcat
		net-analyzer/netcat6
	)
	sys-process/procps
	sys-process/psmisc
	net-firewall/iptables
	media-gfx/graphviz
	x11-libs/libXinerama
	media-libs/glu
"

DEPEND="${RDEPEND}"

S="$S/src"

AUTOTOOLS_IN_SOURCE_BUILD=1

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		$(use_with X x)
		$(use_enable gtk)
		$(use_with modbus libmodbus)
		$(use_with usb libusb-1.0)
		$(usex uspace '--with-realtime=uspace' '')
		--enable-non-distributable=yes
		--with-boost-python=boost_python-2.7
	)
	autotools-utils_src_configure
}
