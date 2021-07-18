#!/usr/bin/env bash

shopt -s expand_aliases
# go paths
if ! [ -x "$(command -v go)" ]; then
	alias go='toolbox run /usr/bin/go'
fi
GOPATH="$(go env GOPATH)"
export GOPATH
export PATH="$GOPATH/bin:$PATH"

export GOFLAGS="-buildmode=pie -trimpath -mod=readonly -modcacherw"

# kubernetes tools
cd "$HOME" || exit

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
	_url="https://github.com/$1/$2/releases/latest/download"
	_version=$(curl -s "$_url" 2>&1 | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+")

	echo "$_version"
}

function gh_version_date() {
	_url="https://github.com/$1/$2/releases/latest/download"
	_version=$(curl -s "$_url" 2>&1 | grep -Eo "[0-9]+\-[0-9]+\-[0-9]+")

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
	curl -L https://storage.googleapis.com/kubernetes-release/release/"$latest"/bin/darwin/arm64/kubectl -o ~/bin/kubectl
	chmod +x ~/bin/kubectl
	update_version kubectl "$latest"
fi
# krew
(
  cd "$(mktemp -d)" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/krew.tar.gz" &&
  tar zxvf krew.tar.gz &&
  KREW=./krew-"$(uname | tr '[:upper:]' '[:lower:]')_$(uname -m | sed -e 's/x86_64/amd64/' -e 's/arm64.*$/arm64/')" && "$KREW" install krew
)


# minikube
latest=v$(gh_version kubernetes minikube)
current=$(get_current_version minikube)
if version_gt "$latest" "$current"; then
	gh_download kubernetes minikube "$latest" minikube-darwin-arm64 ~/bin/minikube
	update_version minikube "$latest"
fi

# kompose
latest=v$(gh_version kubernetes kompose)
current=$(get_current_version kompose)
if version_gt "$latest" "$current"; then
	gh_download kubernetes kompose "$latest" kompose-darwin-amd64 ~/bin/kompose
	update_version kompose "$latest"
fi

# minishift
latest=$(gh_version minishift minishift)
current=$(get_current_version minishift)
if version_gt "$latest" "$current"; then
	curl -LO https://github.com/minishift/minishift/releases/latest/download/minishift-"$latest"-darwin-amd64.tgz
	tar xf minishift-"$latest"-darwin-amd64.tgz
	mv minishift-"$latest"-darwin-amd64/minishift ~/bin/
	rm -rf minishift-"$latest"-darwin-amd64*
	update_version minishift "$latest"
fi

# operator sdk
latest=v$(gh_version operator-framework operator-sdk)
current=$(get_current_version operator-sdk)
if version_gt "$latest" "$current"; then
	gh_download operator-framework operator-sdk "$latest" operator-sdk_darwin_amd64 ~/bin/operator-sdk
	gh_download operator-framework operator-sdk "$latest" ansible-operator_darwin_amd64 ~/bin/ansible-operator
	gh_download operator-framework operator-sdk "$latest" helm-operator_darwin_amd64 ~/bin/helm-operator
	update_version operator-sdk "$latest"
fi

# kustomize
GO111MODULE=on go get sigs.k8s.io/kustomize/kustomize/v3

# kind (kubernetes in docker)
GO111MODULE=on go get sigs.k8s.io/kind@latest

# stern
latest=$(gh_version wercker stern)
current=$(get_current_version stern)
if version_gt "$latest" "$current"; then
	gh_download wercker stern "$latest" stern_darwin_amd64 ~/bin/stern
	update_version stern "$latest"
fi

# k9s
latest=v$(gh_version derailed k9s)
current=$(get_current_version k9s)
if version_gt "$latest" "$current"; then
	gh_download derailed k9s "$latest" k9s_Darwin_arm64.tar.gz k9s.tar.gz
	tar -zxf k9s.tar.gz k9s
	chmod +x k9s
	mv k9s ~/bin/
	rm -f k9s.tar.gz
	update_version k9s "$latest"
fi

# kubectx/kubens
latest=v$(gh_version ahmetb kubectx)
current=$(get_current_version kubectx)
if version_gt "$latest" "$current"; then
	gh_download ahmetb kubectx "$latest" kubectx ~/bin/kubectx
	gh_download ahmetb kubectx "$latest" kubens ~/bin/kubens
	update_version kubectx "$latest"
fi

## github.com/genuinetools/img
#latest=v$(gh_version genuinetools img)
#current=$(get_current_version img)
#if version_gt "$latest" "$current"; then
#	gh_download genuinetools img "$latest" img-linux-amd64 ~/bin/img
#	chmod +x ~/bin/img
#	update_version img "$latest"
#fi

# docker-compose
latest=$(gh_version docker compose)
current=$(get_current_version docker-compose)
if version_gt "$latest" "$current"; then
	gh_download docker compose "$latest" docker-compose-Darwin-x86_64 ~/bin/docker-compose
	chmod +x ~/bin/docker-compose
	update_version docker-compose "$latest"
fi

# k3sup
GO111MODULE=on go get -ldflags "-s -w" github.com/alexellis/k3sup@latest
# arkade
GO111MODULE=on go get -ldflags "-s -w" github.com/alexellis/arkade@latest
# popeye
GO111MODULE=on go get -ldflags "-s -w" github.com/derailed/popeye@latest

# go tools
cd ~/ || exit

go get -u -ldflags "-s -w" golang.org/x/tools/cmd/godoc
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/goimports
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/gorename
go get -u -ldflags "-s -w" golang.org/x/tools/cmd/guru
go get -u -ldflags "-s -w" golang.org/x/lint/golint
go get -u -ldflags "-s -w" golang.org/x/mobile/cmd/gomobile
GO111MODULE=on go get -ldflags "-s -w" golang.org/x/tools/gopls@latest
go get -u -ldflags "-s -w" github.com/rogpeppe/godef
go get -u -ldflags "-s -w" github.com/motemen/gore/cmd/gore
go get -u -ldflags "-s -w" github.com/visualfc/gocode
go get -u -ldflags "-s -w" github.com/zmb3/gogetdoc
go get -u -ldflags "-s -w" github.com/elliotchance/c2go
go get -u -ldflags "-s -w" github.com/go-delve/delve/cmd/dlv
go get -u -ldflags "-s -w" github.com/jstemmer/gotags
go get -u -ldflags "-s -w" github.com/klauspost/asmfmt/cmd/asmfmt
go get -u -ldflags "-s -w" github.com/davidrjenni/reftools/cmd/fillstruct
GO111MODULE=on go get -ldflags "-s -w" github.com/golangci/golangci-lint/cmd/golangci-lint@latest
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
go get -u -ldflags "-s -w" github.com/securego/gosec/v2/cmd/gosec
go get -u -ldflags "-s -w" github.com/cpuguy83/go-md2man
go get -u -ldflags "-s -w" github.com/shurcooL/goexec


# minio client
#wget https://dl.min.io/client/mc/release/linux-amd64/mc
#chmod +x mc
#mv mc ~/bin/

# shfmt
go get -u -ldflags "-s -w" mvdan.cc/sh/cmd/shfmt
# torrent
go get -u -ldflags "-s -w" github.com/anacrolix/torrent/cmd/torrent
# gopass
GO111MODULE=on go get -u -ldflags "-s -w" github.com/gopasspw/gopass@latest

# rust-analyzer
latest=$(gh_version_date rust-analyzer rust-analyzer)
current=$(get_current_version rust-analyzer)
if version_gt "$latest" "$current"; then
	gh_download rust-analyzer rust-analyzer "$latest" rust-analyzer-aarch64-apple-darwin.gz rust-analyzer.gz
	gunzip rust-analyzer.gz
	chmod +x rust-analyzer
	mv rust-analyzer ~/bin/
	rm -f ra.tar.gz
	update_version rust-analyzer "$latest"
fi

