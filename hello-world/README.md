# Hello World Example

In this example, we use the Landscaper to deploy a Helm chart.

Our [hello-world Helm chart](chart/hello-world) is minimalistic. It contains just a ConfigMap.
We have uploaded the chart to a public registry, from where the Landscaper reads it during the deployment.

Altogether, there occur three clusters in this example, however some or all of them may coincide:

- the **Landscaper host cluster**, on which the Landscaper runs;
- the **Landscaper data cluster**, on which custom resources like Targets and Installations can be created,
  that are watched by the Landscaper;
- the **target cluster**, on which the Helm chart shall be deployed.


## Procedure

1. Insert in file [target.yaml](installation/target.yaml) the kubeconfig of your target cluster.  

2. On the Landscaper data cluster, create namespace `example` and apply 
   the [target.yaml](installation/target.yaml) and
   the [installation.yaml](installation/installation.yaml).
   
   ```shell
   kubectl create ns example
   kubectl apply -f <path to target.yaml>
   kubectl apply -f <path to installation.yaml>
   ```

Alternative (requires the [Landscaper CLI](https://github.com/gardener/landscapercli)):

1. In the [commands/settings file](./commands/settings), specify 
   - the path to the kubeconfig of your Landscaper data cluster and
   - the path to the kubeconfig of your target cluster.

2. Run script [commands/apply-target-and-installation.sh](./commands/apply-target-and-installation.sh).


## Inspect the Result

You can now check the status of the Installation and its DeployItem:

```shell
kubectl get inst -n example hello-world
kubectl get di -n example hello-world-...
```

If you have already installed the [Landscaper CLI](https://github.com/gardener/landscapercli), 
you can inspect the status of the installation with the following command, executed on the Landscaper data cluster:

```shell
landscaper-cli inst inspect -n example hello-world
```

On the target cluster, you should find the ConfigMap, that was deployed as part of the Helm chart:

```shell
kubectl get configmap -n example hello-world
```
