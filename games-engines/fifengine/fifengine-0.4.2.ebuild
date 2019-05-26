# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( pypy{,3} python{2_7,3_{5,6}} )

inherit python-single-r1 cmake-utils

DESCRIPTION="Flexible Isometric Free Engine, 2D"
HOMEPAGE="http://fifengine.de"
if [[ "${PV}" == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="debug +opengl +zip +fifechan cegui +python"

RDEPEND="
	cegui? ( dev-games/cegui )
	fifechan? ( games-engines/fifechan )
	dev-libs/tinyxml
	media-libs/libpng:0
	media-libs/mesa
	>=dev-libs/boost-1.33.1
	media-libs/libsdl2[opengl]
	media-libs/sdl2-ttf
	media-libs/sdl2-image[png]
	media-libs/libvorbis
	media-libs/libogg
	media-libs/openal
	media-libs/glew
	>=sys-libs/zlib-1.2
	x11-libs/libXcursor
	x11-libs/libXext
	virtual/opengl

	python? (
		dev-python/pyyaml[${PYTHON_USEDEP}]
		${PYTHON_DEPS}
	)
"
DEPEND="
	${RDEPEND}
	python? ( >=dev-lang/swig-1.3.40 )
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

#PATCHES=( "${FILESDIR}/${P}-unbundle-libpng.patch" )

usx() { usex $* ON OFF; }

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local mycmakeargs=(
		-Dopengl=$(usx opengl)
		-Dfifechan=$(usx fifechan)
		-Dlibrocket=$(usx librocket)
		-Dcegui=$(usx cegui)
		-Dlogging=$(usx log)
		-Dbuild-python=$(usx python)
		-Dbuild-library=ON
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
