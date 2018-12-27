#!/usr/bin/env bash
# Program to set snap's version, used by the `version-script` keyword
# 林博仁(Buo-ren, Lin) <Buo.Ren.Lin@gmail.com> © 2018

set \
    -o errexit \
    -o errtrace \
    -o nounset \
    -o pipefail

init(){
    local \
        upstream_version \
        packaging_revision

    upstream_version="$(
        # FIXME: Should be more robust
        grep \
            '^AC_INIT(' \
            <parts/filezilla/src/configure.ac \
        | cut \
            --characters=9- \
        | cut \
            --delimiter=, \
            --fields=2 \
        | sed \
            's/^.\(.*\).$/\1/'
    )"

    packaging_revision="$(
        git \
            describe \
            --abbrev=4 \
            --always \
            --match nothing \
            --dirty=-d
    )"

    printf \
        -- \
        '%s' \
        "${upstream_version}+pkg-${packaging_revision}"

    exit 0
}

init "${@}"
