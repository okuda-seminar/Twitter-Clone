# Using Kustomize for Environment Switching in Blue-Green Rollouts

This repository demonstrates how to use Kustomize to switch between Blue-Green rollouts in pre and stg environments.
This allows you to switch between Blue-Green rollouts in the `prd` and `stg` environments.

## Configuration

- `base`: The base directory contains definitions for deployment and active/preview services.
- `overlays/pre`: Contains an overlay for the `pre` environment, including a patch to change the service port.
- `overlays/stg`: Contains an overlay for the `stg` environment, including a patch to change the service port.

## Usage
0. `kubectl config use-context <the name of cluster>` 
1. Navigate to the `overlays/pre` or `overlays/stg` directory.
2. Use `kubectl apply -k .` to apply the manifests for each environment.



## Appendix
$ kubectl -n argocd get secret/argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
WFk9fslhg3lATGoC

