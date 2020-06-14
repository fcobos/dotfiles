#!/usr/bin/env bash
# helm
export USE_SUDO=false
export HELM_INSTALL_DIR=~/bin/
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
rm -f ./get_helm.sh

# kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
mv kubectl ~/bin/

# minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
mv minikube-linux-amd64 ~/bin/minikube
chmod +x ~/bin/minikube

# minishift
VERSION=$(curl -s https://github.com/minishift/minishift/releases/latest/download 2>&1 | grep -Po "[0-9]+\.[0-9]+\.[0-9]+")
echo version: "$VERSION"
wget https://github.com/minishift/minishift/releases/latest/download/minishift-"$VERSION"-linux-amd64.tgz
tar xf minishift-"$VERSION"-linux-amd64.tgz
mv minishift-"$VERSION"-linux-amd64/minishift ~/bin/
rm -rf minishift-"$VERSION"-linux-amd64*
