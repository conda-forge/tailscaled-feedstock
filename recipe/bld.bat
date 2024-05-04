@echo on

cd %SRC_DIR%/git
for /f "delims=" %%a IN ('git rev-parse HEAD') do set GIT_COMMIT_SHA=%%a
set "GIT_SHORT_SHA=!GIT_COMMIT_SHA:~0,9!"

cd %SRC_DIR%/release/cmd/tailscaled

go-licenses save . ^
    --save_path ../../library_licenses

go install -v ^
    -ldflags "-s -w -X 'tailscale.com/version.shortStamp=v%PKG_VERSION%' -X 'tailscale.com/version.longStamp=%PKG_VERSION%-t%GIT_SHORT_SHA%' -X 'tailscale.com/version.gitCommitStamp=%GIT_COMMIT_SHA%'" ^
    .
