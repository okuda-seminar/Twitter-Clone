kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -n argo-rollouts -f https://raw.githubusercontent.com/argoproj/argo-rollouts/stable/manifests/install.yaml



https://github.com/argoproj/argo-cd/blob/master/docs/getting_started.md

https://techstep.hatenablog.com/entry/2020/10/11/112027