
cluster="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')"
token="$(KUBECONFIG=./kubeconfig.json kubectl -n kube-system describe secret ${cluster})"
echo "token: ${token}"
KUBECONFIG=./kubeconfig.json kubectl proxy
