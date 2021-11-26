#!/bin/bash

function read_file() {
	if [[ -f $1 ]]; then 
		echo -n ""
	else
		exit 1
	fi

	if [[ $(cat $1 | wc -c) -eq 0 ]]; then
		exit 1
	else
		echo -n ""
	fi
}

function find_secrets() {
	secrets=$(find / -name "token" -exec grep "^eyJ" {} \; 2>/dev/null)
	if [[ -n "${secrets}" ]]; then
		echo -n ""
	else
		unset secrets
		exit 1
	fi
}

function ip_info() {
	ip addr || ip a || ifconfig || ipconfig
	cat /etc/hosts
}


config_files() {
	echo "$HOME/.kube/config
/var/lib/kubelet/config.yaml
/etc/kubernetes/kubelet.conf
/var/lib/kubelet/kubeadm-flags.env
/etc/kubernetes/manifests/etcd.yaml
/etc/kubernetes/bootstrap-kubelet.conf
/etc/kubernetes/pki"
	

}

#read_file "/run/secrets/kubernetes.io/serviceaccount/token" && echo "[*] Secrets file found!" || find_secrets
#ip_info
config_files

kubenum