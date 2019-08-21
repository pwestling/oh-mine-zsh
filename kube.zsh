alias kube=kubectl

create_aws_kops_cluster(){
  CONFIG_FILE=$1
  CLUSTER_NAME=$(cat $CONFIG_FILE | yq -r .metadata.name)
  kops create -f $CONFIG_FILE
  kops update cluster --name=$CLUSTER_NAME --yes
}
delete_aws_kops_cluster(){
  CONFIG_FILE=$1
  kops delete -f $CONFIG_FILE --yes
}

kube_logs(){
  ARGS=${2:-""}
  kubectl wait --for=condition=Ready --timeout=2m pod/$1
  kubectl logs -f $1 $ARGS | format_kube_logs
}

kcontext(){
  kubectl config get-contexts | tr -s " " | cut -d" " -f2 | grep -v NAME | grep $1 
}

kroll(){
  kind=$1
  name=$2
  shift
  shift
  kubectl set env $kind/$name  $@ "ROLL_RESOURCE=$(date +%s)"
}

ctx(){
  old=$(kubectl config current-context)
  kubectl config use-context $(kcontext $1)
  if [[ $(kcontext $1) == $(kcontext colo) && $old != $(kcontext colo) ]]; then
    brew switch kubectl 1.8.4
  elif [[ $old == $(kcontext colo) && $(kcontext $1) != $(kcontext colo) ]]; then
    brew switch kubectl 1.11.1
  fi
}

source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_NS_ENABLE=false

unset KUBECONFIG
