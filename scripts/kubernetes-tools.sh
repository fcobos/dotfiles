#!/usr/bin/env bash
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
minishift_version=$(curl -s https://github.com/minishift/minishift/releases/latest/download 2>&1 | grep -Po "[0-9]+\.[0-9]+\.[0-9]+")
echo version: "$minishift_version"
wget https://github.com/minishift/minishift/releases/latest/download/minishift-"$minishift_version"-linux-amd64.tgz
tar xf minishift-"$minishift_version"-linux-amd64.tgz
mv minishift-"$minishift_version"-linux-amd64/minishift ~/bin/
rm -rf minishift-"$minishift_version"-linux-amd64*

# operator sdk
operator_version=v$(curl -s https://github.com/operator-framework/operator-sdk/releases/latest/download 2>&1 | grep -Po "[0-9]+\.[0-9]+\.[0-9]+")
operator_install_dir=~/bin/
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/operator-sdk-"${operator_version}"-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/ansible-operator-"${operator_version}"-x86_64-linux-gnu
curl -LO https://github.com/operator-framework/operator-sdk/releases/download/"${operator_version}"/helm-operator-"${operator_version}"-x86_64-linux-gnu
chmod +x operator-sdk-"${operator_version}"-x86_64-linux-gnu && cp operator-sdk-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/operator-sdk && rm operator-sdk-"${operator_version}"-x86_64-linux-gnu
chmod +x ansible-operator-"${operator_version}"-x86_64-linux-gnu && cp ansible-operator-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/ansible-operator && rm ansible-operator-"${operator_version}"-x86_64-linux-gnu
chmod +x helm-operator-"${operator_version}"-x86_64-linux-gnu && cp helm-operator-"${operator_version}"-x86_64-linux-gnu $operator_install_dir/helm-operator && rm helm-operator-"${operator_version}"-x86_64-linux-gnu
