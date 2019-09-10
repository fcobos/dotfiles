#!/usr/bin/env bash
cd ~/

go get -u -ldflags "-s -w" golang.org/x/tools/cmd/godoc
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/goimports
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/gorename
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/guru
go get -u -ldflags "-s -w" golang.org/x/lint/golint
go get -u -ldflags "-s -w" golang.org/x/mobile/cmd/gomobile
GO111MODULE=on go get -ldflags "-s -w" golang.org/x/tools/cmd/gopls@latest
#mkdir ~/.cache/go-tools
#cd ~/.cache/go-tools
#git clone -b bingo https://github.com/saibing/tools.git
#cd tools/cmd/gopls
#go install
#cd ~/
#rm -rf ~/.cache/go-tools
#go get -u -ldflags "-s -w" github.com/saibing/bingo

go get -u -ldflags "-s -w" github.com/rogpeppe/godef
go get -u -ldflags "-s -w" github.com/motemen/gore
#go get -u -ldflags "-s -w" github.com/mdempsky/gocode
#go get -u -ldflags "-s -w" github.com/stamblerre/gocode
go get -u -ldflags "-s -w" github.com/visualfc/gocode
go get -u -ldflags "-s -w" github.com/zmb3/gogetdoc
go get -u -ldflags "-s -w" github.com/elliotchance/c2go
go get -u -ldflags "-s -w" github.com/go-delve/delve/cmd/dlv
go get -u -ldflags "-s -w" github.com/jstemmer/gotags
go get -u -ldflags "-s -w" github.com/klauspost/asmfmt/cmd/asmfmt
go get -u -ldflags "-s -w" github.com/davidrjenni/reftools/cmd/fillstruct
go get -u -ldflags "-s -w" github.com/alecthomas/gometalinter
go get -u -ldflags "-s -w" github.com/golangci/golangci-lint/cmd/golangci-lint
go get -u -ldflags "-s -w" github.com/fatih/gomodifytags
go get -u -ldflags "-s -w" github.com/josharian/impl
go get -u -ldflags "-s -w" honnef.co/go/tools/cmd/keyify
go get -u -ldflags "-s -w" github.com/fatih/motion
go get -u -ldflags "-s -w" github.com/koron/iferr
go get -u -ldflags "-s -w" github.com/mdempsky/unconvert
go get -u -ldflags "-s -w" honnef.co/go/tools/cmd/staticcheck
go get -u -ldflags "-s -w" github.com/kisielk/errcheck
go get -u -ldflags "-s -w" github.com/godoctor/godoctor
go get -u -ldflags "-s -w" github.com/cweill/gotests/...
go get -u -ldflags "-s -w" github.com/securego/gosec/cmd/gosec
