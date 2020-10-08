#!/usr/bin/env bash

cd "$HOME" || exit

gh_version() {
	_url="https://github.com/$1/$2/releases/latest/download"
	_version=$(curl -s "$_url" 2>&1 | grep -Po "[0-9]+\.[0-9]+\.[0-9]+")

	echo "$_version"
}

gh_download() {
	curl -L "https://github.com/$1/$2/releases/download/$3/$4" -o "$5"
}

# helm
export USE_SUDO=false
export HELM_INSTALL_DIR=~/bin/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f ./get_helm.sh

# kubectl
kubectl_version=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO https://storage.googleapis.com/kubernetes-release/release/"$kubectl_version"/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl ~/bin/

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
mv minikube-linux-amd64 ~/bin/minikube
chmod +x ~/bin/minikube

# kompose
curl -L https://github.com/kubernetes/kompose/releases/latest/download/kompose-linux-amd64 -o kompose
chmod +x kompose
mv kompose ~/bin/

# minishift
minishift_version=$(gh_version minishift minishift)
echo version: "$minishift_version"
wget https://github.com/minishift/minishift/releases/latest/download/minishift-"$minishift_version"-linux-amd64.tgz
tar xf minishift-"$minishift_version"-linux-amd64.tgz
mv minishift-"$minishift_version"-linux-amd64/minishift ~/bin/
rm -rf minishift-"$minishift_version"-linux-amd64*

# operator sdk
operator_version=v$(gh_version operator-framework operator-sdk)
operator_install_dir=~/bin/
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/operator-sdk-"${operator_version}"-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/ansible-operator-"${operator_version}"-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/helm-operator-"${operator_version}"-x86_64-linux-gnu
chmod +x operator-sdk-"${operator_version}"-x86_64-linux-gnu && cp operator-sdk-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/operator-sdk && rm operator-sdk-"${operator_version}"-x86_64-linux-gnu
chmod +x ansible-operator-"${operator_version}"-x86_64-linux-gnu && cp ansible-operator-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/ansible-operator && rm ansible-operator-"${operator_version}"-x86_64-linux-gnu
chmod +x helm-operator-"${operator_version}"-x86_64-linux-gnu && cp helm-operator-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/helm-operator && rm helm-operator-"${operator_version}"-x86_64-linux-gnu

# kustomize
GO111MODULE=on go get sigs.k8s.io/kustomize/kustomize/v3

# kind (kubernetes in docker)
GO111MODULE=on go get sigs.k8s.io/kind@latest

# stern
gh_download wercker stern "$(gh_version wercker stern)" stern_linux_amd64 stern
chmod +x stern
mv stern ~/bin/

## docker-machine
#docker_machine_version=v$(gh_version docker machine)
#gh_download docker machine "v$(gh_version docker machine)" docker-machine-"$(uname -s)"-"$(uname -m)" docker-machine
#chmod +x docker-machine
#mv docker-machine ~/bin/

## k3d
#gh_download rancher k3d "$(gh_version rancher k3d)" k3d-linux-amd64 k3d
#chmod +x k3d
#mv k3d ~/bin/

# k9s
gh_download derailed k9s "v$(gh_version derailed k9s)" k9s_Linux_x86_64.tar.gz k9s.tar.gz
tar -zxf k9s.tar.gz k9s
chmod +x k9s
mv k9s ~/bin/
rm -f k9s.tar.gz
