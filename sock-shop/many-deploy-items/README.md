# Sock Shop Example

Deploys the [sock shop app][1] with Landscaper.

The blueprint has many deploy items, all using the manifest deployer. 

## Procedure

On the landscaper cluster create the following objects:

- Namespace `sock-shop-inst`
- A target with name `my-cluster` in namespace `sock-shop-inst`. It must contain the kubeconfig of the target cluster
  where the sock shop shall be installed.
- Installation [installation.yaml](./installation.yaml)

Landscaper will then install the sock shop in namespace `sock-shop` on the target cluster.


[1]: https://github.com/microservices-demo/microservices-demo/blob/master/deploy/kubernetes/complete-demo.yaml
