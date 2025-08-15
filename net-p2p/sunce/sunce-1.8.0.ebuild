# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="User-friendly Montelibero wallet for the Stellar ecosystem"
HOMEPAGE="https://github.com/SunceWallet/sunce"

deps="${P}-deps.tar.xz"
if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/SunceWallet/sunce"
	SRC_URI="$deps"
else
	SRC_URI="
		https://github.com/SunceWallet/sunce/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/l29ah/gentoo-overlay-blobs/raw/refs/heads/master/$deps"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"

DEPEND="net-libs/nodejs"
BDEPEND="net-libs/nodejs[npm]"

if [[ ${PV} == *9999* ]]; then
	src_unpack() {
		cd "${T}" || die "Could not cd to temporary directory"
		unpack "${deps}"
		git-r3_src_unpack
	}
else
	src_prepare() {
		mv ../npm-cache "${T}"/
		default
	}
fi

src_install() {
	webapp_src_preinst

	# electron tries to download stuff from the network sandbox
	sed -i -e '/electron/d' package.json

	einfo npm install
	npm \
		--offline \
		--verbose \
		--progress false \
		--foreground-scripts \
		--cache "${T}"/npm-cache \
		install || die "npm failed"

	einfo npm run build:web
	npm \
		--offline \
		--verbose \
		--progress false \
		--foreground-scripts \
		--cache "${T}"/npm-cache \
		run build:web || die "npm failed"

	insinto "${MY_HTDOCSDIR}"
	doins -r dist/*

	webapp_src_install
}
