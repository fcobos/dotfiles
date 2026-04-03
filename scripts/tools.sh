#!/usr/bin/env bash

shopt -s expand_aliases
# go paths
GOPATH="$(go env GOPATH)"
export GOPATH
export PATH="$GOPATH/bin:$PATH"

export GOFLAGS="-buildmode=pie -trimpath"

# kubernetes tools
cd /tmp || exit

versions_file="$HOME/.cache/kubernetes-tools-versions"

if [ ! -f "$versions_file" ]; then
	touch "$versions_file"
fi

function update_version() {
	current_value=$(grep "$1" "$versions_file")
	if [ -n "$current_value" ]; then
		sed -i '' -e "s/$current_value/$1:$2/g" "$versions_file"
	else
		echo "$1:$2" >> "$versions_file"
	fi
}

function version_gt() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

function get_current_version() {
	current=$(grep "$1" "$versions_file" | cut -d ':' -f 2)
	if [ -z "$current" ]; then
		current="0.0.0"
	fi

	echo "$current"
}

function gh_version() {
	_url="https://api.github.com/repos/$1/$2/releases/latest"
	_version=$(curl -s "$_url" 2>&1 | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

	echo "$_version"
}

function gh_version_date() {
	_url="https://api.github.com/repos/$1/$2/releases/latest"
	_version=$(curl -s "$_url" 2>&1 | grep '"tag_name":' | grep -Eo "[0-9]+\-[0-9]+\-[0-9]+")

	echo "$_version"
}

function gh_download() {
	curl -L "https://github.com/$1/$2/releases/download/$3/$4" -o "$5"
	chmod +x "$5"
}

# go tools
cd ~/ || exit

go install -ldflags "-s -w" golang.org/x/tools/cmd/godoc@latest
go install -ldflags "-s -w" golang.org/x/tools/cmd/goimports@latest
go install -ldflags "-s -w" golang.org/x/tools/cmd/gorename@latest
go install -ldflags "-s -w" golang.org/x/tools/cmd/guru@latest
go install -ldflags "-s -w" golang.org/x/lint/golint@latest
go install -ldflags "-s -w" golang.org/x/mobile/cmd/gomobile@latest
go install -ldflags "-s -w" golang.org/x/tools/gopls@latest
go install -ldflags "-s -w" github.com/rogpeppe/godef@latest
go install -ldflags "-s -w" github.com/x-motemen/gore/cmd/gore@latest
go install -ldflags "-s -w" github.com/visualfc/gocode@latest
go install -ldflags "-s -w" github.com/zmb3/gogetdoc@latest
go install -ldflags "-s -w" github.com/elliotchance/c2go@latest
go install -ldflags "-s -w" github.com/go-delve/delve/cmd/dlv@latest
go install -ldflags "-s -w" github.com/jstemmer/gotags@latest
go install -ldflags "-s -w" github.com/klauspost/asmfmt/cmd/asmfmt@latest
go install -ldflags "-s -w" github.com/davidrjenni/reftools/cmd/fillstruct@latest
go install -ldflags "-s -w" github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install -ldflags "-s -w" github.com/fatih/gomodifytags@latest
go install -ldflags "-s -w" github.com/josharian/impl@latest
go install -ldflags "-s -w" honnef.co/go/tools/cmd/keyify@latest
go install -ldflags "-s -w" github.com/fatih/motion@latest
go install -ldflags "-s -w" github.com/koron/iferr@latest
go install -ldflags "-s -w" github.com/mdempsky/unconvert@latest
go install -ldflags "-s -w" honnef.co/go/tools/cmd/staticcheck@latest
go install -ldflags "-s -w" github.com/kisielk/errcheck@latest
go install -ldflags "-s -w" github.com/godoctor/godoctor@latest
go install -ldflags "-s -w" github.com/cweill/gotests/...@latest
go install -ldflags "-s -w" github.com/securego/gosec/v2/cmd/gosec@latest
go install -ldflags "-s -w" github.com/cpuguy83/go-md2man@latest
go install -ldflags "-s -w" github.com/shurcooL/goexec@latest


