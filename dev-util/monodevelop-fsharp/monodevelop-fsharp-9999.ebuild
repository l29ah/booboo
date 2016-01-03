# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="https://github.com/o01eg/fsharpbinding.git"

inherit git-2 eutils mono multilib versionator

DESCRIPTION="F# language binding for MonoDevelop"
HOMEPAGE="fsharpbinding"
SRC_URI=""

LICENSE="Apache 2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="=dev-dotnet/fsharp-9999
dev-lang/mono
=dev-util/monodevelop-2.8.2
dev-dotnet/mono-addins"
RDEPEND="${DEPEND}"

#src_prepare()
#{
#	epatch "${FILESDIR}/fsharpbinding-net4.0.patch"
#}

src_configure()
{
	./configure.sh
}

src_compile() {
	emake
}

src_install()
{
	#emake DESTDIR="${D}" install
	dodoc README
	dodir /usr/lib/monodevelop/AddIns/BackendBindings/
	insinto /usr/lib/monodevelop/AddIns/BackendBindings/
	doins bin/FSharpBinding.*
	mono_multilib_comply
}

