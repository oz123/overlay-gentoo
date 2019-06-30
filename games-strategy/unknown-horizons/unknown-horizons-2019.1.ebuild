# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6,7} pypy )
DISTUTILS_SINGLE_IMPL=1
PYTHON_REQ_USE="sqlite"

inherit distutils-r1

if [[ ${PV} == *9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/${PN}/${PN}"
else
	SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Anno-like real time strategy game"
HOMEPAGE="http://www.unknown-horizons.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE="test"

RDEPEND="
	dev-python/future[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/pyyaml[${PYTHON_USEDEP}]
	test? (
		dev-python/greenlet[${PYTHON_USEDEP}]
		dev-python/polib[${PYTHON_USEDEP}]
		dev-python/isort[${PYTHON_USEDEP}]
		dev-python/pylint[${PYTHON_USEDEP}]
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/nose[${PYTHON_USEDEP}]
		dev-python/pycodestyle[${PYTHON_USEDEP}]
	)
	=games-engines/fifengine-0.4.2[python,${PYTHON_USEDEP}]
	games-engines/fifechan
	${PYTHON_DEPS}
"

DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_test() {
	${PYTHON} ./run_tests.py
}

src_compile() {
	distutils-r1_src_compile build_i18n
}
