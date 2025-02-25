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

# helm
export USE_SUDO=false
export HELM_INSTALL_DIR=~/bin/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f ./get_helm.sh

# kubectl
latest=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
current=$(get_current_version kubectl)
if version_gt "$latest" "$current"; then
	curl -L https://storage.googleapis.com/kubernetes-release/release/"$latest"/bin/linux/amd64/kubectl -o ~/bin/kubectl
	chmod +x ~/bin/kubectl
	update_version kubectl "$latest"
fi
# krew
latest=$(gh_version kubernetes-sigs krew)
current=$(get_current_version krew)
if version_gt "$latest" "$current"; then
	gh_download kubernetes-sigs krew "$latest" krew-linux_amd64.tar.gz krew.tar.gz
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm64.*$/arm64/')" && "$KREW" install krew
  rm -f krew.tar.gz "$KREW"
	update_version krew "$latest"
fi

# minikube
latest=$(gh_version kubernetes minikube)
current=$(get_current_version minikube)
if version_gt "$latest" "$current"; then
	gh_download kubernetes minikube "$latest" minikube-linux-amd64 ~/bin/minikube
	update_version minikube "$latest"
fi

# kompose
latest=$(gh_version kubernetes kompose)
current=$(get_current_version kompose)
if version_gt "$latest" "$current"; then
	gh_download kubernetes kompose "$latest" kompose-linux-amd64 ~/bin/kompose
	update_version kompose "$latest"
fi

## minishift
#latest=$(gh_version minishift minishift)
#current=$(get_current_version minishift)
#if version_gt "$latest" "$current"; then
#	curl -LO https://github.com/minishift/minishift/releases/latest/download/minishift-"$latest"-linux-amd64.tgz
#	tar xf minishift-"$latest"-linux-amd64.tgz
#	mv minishift-"$latest"-linux-amd64/minishift ~/bin/
#	rm -rf minishift-"$latest"-linux-amd64*
#	update_version minishift "$latest"
#fi

# operator sdk
latest=$(gh_version operator-framework operator-sdk)
current=$(get_current_version operator-sdk)
if version_gt "$latest" "$current"; then
	gh_download operator-framework operator-sdk "$latest" operator-sdk_linux_amd64 ~/bin/operator-sdk
	gh_download operator-framework operator-sdk "$latest" ansible-operator_linux_amd64 ~/bin/ansible-operator
	gh_download operator-framework operator-sdk "$latest" helm-operator_linux_amd64 ~/bin/helm-operator
	update_version operator-sdk "$latest"
fi

# kustomize
GO111MODULE=on go install -ldflags "-s -w" sigs.k8s.io/kustomize/kustomize/v4@latest

# kind (kubernetes in docker)
go install -ldflags "-s -w" sigs.k8s.io/kind@latest

# stern
latest=$(gh_version wercker stern)
current=$(get_current_version stern)
if version_gt "$latest" "$current"; then
	gh_download wercker stern "$latest" stern_linux_amd64 ~/bin/stern
	update_version stern "$latest"
fi

# kubectx/kubens
latest=$(gh_version ahmetb kubectx)
current=$(get_current_version kubectx)
if version_gt "$latest" "$current"; then
	gh_download ahmetb kubectx "$latest" kubectx ~/bin/kubectx
	gh_download ahmetb kubectx "$latest" kubens ~/bin/kubens
	update_version kubectx "$latest"
fi

## github.com/genuinetools/img
#latest=$(gh_version genuinetools img)
#current=$(get_current_version img)
#if version_gt "$latest" "$current"; then
#	gh_download genuinetools img "$latest" img-linux-amd64 ~/bin/img
#	chmod +x ~/bin/img
#	update_version img "$latest"
#fi

## docker-compose
#latest=$(gh_version docker compose)
#current=$(get_current_version docker-compose)
#if version_gt "$latest" "$current"; then
#	gh_download docker compose "$latest" docker-compose-linux-x86_64 ~/.docker/cli-plugins/docker-compose
#	chmod +x ~/.docker/cli-plugins/docker-compose
#	update_version docker-compose "$latest"
#fi

# k3sup
go install -ldflags "-s -w" github.com/alexellis/k3sup@latest
# arkade
go install -ldflags "-s -w" github.com/alexellis/arkade@latest
# popeye
go install -ldflags "-s -w" github.com/derailed/popeye@latest

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


# minio client
#wget https://dl.min.io/client/mc/release/linux-amd64/mc
#chmod +x mc
#mv mc ~/bin/

# shfmt
go install -ldflags "-s -w" mvdan.cc/sh/cmd/shfmt@latest
# torrent
go install -ldflags "-s -w" github.com/anacrolix/torrent/cmd/torrent@latest
# gopass
go install -ldflags "-s -w" github.com/gopasspw/gopass@latest

