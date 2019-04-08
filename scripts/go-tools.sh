#!/usr/bin/env bash

go get -u golang.org/x/tools/cmd/godoc
go get -u golang.org/x/tools/cmd/goimports
go get -u golang.org/x/tools/cmd/gorename
go get -u golang.org/x/tools/cmd/guru
go get -u golang.org/x/lint/golint
go get -u golang.org/x/mobile/cmd/gomobile
go get -u golang.org/x/tools/cmd/gopls
#mkdir ~/.cache/go-tools
#cd ~/.cache/go-tools
#git clone -b bingo https://github.com/saibing/tools.git
#cd tools/cmd/gopls
#go install
#cd ~/
#rm -rf ~/.cache/go-tools
go get -u github.com/saibing/bingo

go get -u github.com/rogpeppe/godef
go get -u github.com/motemen/gore
#go get -u github.com/mdempsky/gocode
#go get -u github.com/stamblerre/gocode
go get -u github.com/visualfc/gocode
go get -u github.com/zmb3/gogetdoc
go get -u github.com/elliotchance/c2go
go get -u github.com/go-delve/delve/cmd/dlv
go get -u github.com/jstemmer/gotags
go get -u github.com/klauspost/asmfmt/cmd/asmfmt
go get -u github.com/kisielk/errcheck
go get -u github.com/davidrjenni/reftools/cmd/fillstruct
go get -u github.com/alecthomas/gometalinter
go get -u github.com/golangci/golangci-lint/cmd/golangci-lint
go get -u github.com/fatih/gomodifytags
go get -u github.com/josharian/impl
go get -u honnef.co/go/tools/cmd/keyify
go get -u github.com/fatih/motion
go get -u github.com/koron/iferr

# strip binaries
cd $GOPATH/bin
for f in * ; do strip --strip-all $f ; done
