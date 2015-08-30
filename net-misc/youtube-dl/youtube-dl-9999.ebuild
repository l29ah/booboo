# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=(python{2_7,3_3,3_4})
DISTUTILS_SINGLE_IMPL=true
inherit bash-completion-r1 distutils-r1 eutils git-r3

DESCRIPTION="Download videos from YouTube.com (and more sites...)"
HOMEPAGE="https://rg3.github.com/youtube-dl/"
EGIT_REPO_URI="https://github.com/rg3/youtube-dl/"

LICENSE="public-domain"
SLOT="0"
KEYWORDS=""
IUSE="offensive test"

DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[coverage(+)] )
"

src_prepare() {
	if ! use offensive; then
		sed -i -e "/__version__/s|'$|-gentoo_no_offensive_sites'|g" \
			youtube_dl/version.py || die
		# these have single line import statements
		local xxx=(
			alphaporno anysex behindkink drtuber eporner eroprofile extremetube
			fourtube foxgay goshgay hellporno hentaistigma hornbunny keezmovies
			mofosex motherless porn91 pornhd pornotube pornovoisines pornoxo
			redtube sexykarma sexu sunporno slutload spankbang spankwire thisav
			trutube tube8 vporn xbef xnxx xtube xvideos xxxymovies youjizz
			youporn
		)
		# these have multi-line import statements
		local mxxx=(
			pornhub xhamster tnaflix
		)
		# do single line imports
		sed -i \
			-e $( printf '/%s/d;' ${xxx[@]} ) \
			youtube_dl/extractor/__init__.py \
			|| die

		# do multiple line imports
		sed -i \
			-e $( printf '/%s/,/)/d;' ${mxxx[@]} ) \
			youtube_dl/extractor/__init__.py \
			|| die

		sed -i \
			-e $( printf '/%s/d;' ${mxxx[@]} ) \
			youtube_dl/extractor/generic.py \
			youtube_dl/extractor/tumblr.py \
			|| die

		rm \
			$( printf 'youtube_dl/extractor/%s.py ' ${xxx[@]} ) \
			$( printf 'youtube_dl/extractor/%s.py ' ${mxxx[@]} ) \
			test/test_age_restriction.py \
			|| die
	fi

	epatch_user
}

src_compile() {
	distutils-r1_src_compile
}

src_test() {
	emake test
}

src_install() {
	python_domodule youtube_dl
	dobin bin/${PN}
	dodoc README.md
	# TODO build docs/
	#doman ${PN}.1
	# TODO build devscripts/
	#newbashcomp ${PN}.bash-completion ${PN}
	python_fix_shebang "${ED}"
}
