#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

GIT_COMMIT_SHA=$(cd $SRC_DIR/git && git rev-parse HEAD)
GIT_SHORT_SHA=${GIT_COMMIT_SHA:0:9}

cd $SRC_DIR/release/cmd/tailscaled

go-licenses save . \
    --save_path ../../library_licenses

go build -v \
    -ldflags "-s -w -X 'tailscale.com/version.shortStamp=$PKG_VERSION' -X 'tailscale.com/version.longStamp=$PKG_VERSION-t$GIT_SHORT_SHA' -X 'tailscale.com/version.gitCommitStamp=$GIT_COMMIT_SHA'" \
    -o $PREFIX/bin/tailscaled
