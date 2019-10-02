# note1: this script only work for replicas=1 pod
# note2: this script doesnt support a multi-containers pod
name=$1
cli=$2

kubectl exec -it `kubectl get pods|grep $name|awk '{print $1}'` $cli
#kubectl exec -it `kubectl get pods|grep nginx|awk '{print $1}'` bash
