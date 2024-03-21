# Using Kustomize for Environment Switching in Blue-Green Rollouts

This repository demonstrates how to use Kustomize to switch between Blue-Green rollouts in prd and stg environments.
This allows you to switch between Blue-Green rollouts in the `prd` and `stg` environments.

## Configuration

- `base`: The base directory contains definitions for deployment and active/preview services.
- `overlays/prd`: Contains an overlay for the `prd` environment, including a patch to change the service port.
- `overlays/stg`: Contains an overlay for the `stg` environment, including a patch to change the service port.

## Usage
0. `kubectl config use-context <the name of cluster>`
1. allow argo-rollouts to access config map
```
kubectl create rolebinding argo-rollouts-config-view --clusterrole=view --serviceaccount=default:argo-rollouts
```
2. create resources
- base env
```
kustomize build kustomize/base | kubectl apply -f -
```
- stg env
```
kustomize build kustomize/overlays/stg | kubectl apply  -f -
```

## Appendix
```
kubectl -n argocd get secret/argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```
WFk9fslhg3lATGoC

