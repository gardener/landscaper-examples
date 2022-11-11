# Hello World Example

In this example, we use the Landscaper to deploy a Helm chart.

Our [hello-world Helm chart](chart/hello-world) is minimalistic. It contains just a ConfigMap.
We have uploaded the chart to a public registry, from where the Landscaper reads it during the deployment.


## Prerequisites

As a prerequisite we need a running Landscaper. 
Altogether, three clusters occur. However, some or all of them may coincide:

- the **Landscaper host cluster**, on which the Landscaper runs;
- the **Landscaper data cluster**, on which custom resources like Targets and Installations can be created,
  that are watched by the Landscaper;
- the **targets cluster**, on which the Helm chart shall be deployed.


## Procedure

1. Insert in file [target.yaml](installation/target.yaml) the kubeconfig of your target cluster.  

2. On the Landscaper data cluster, create namespace `example` and apply 
   the [target.yaml](installation/target.yaml) and
   the [installation.yaml](installation/installation.yaml).

   See script [apply-target-and-installation.sh](commands/apply-target-and-installation.sh).


## Inspect the Result

If you have already installed the [Landscaper CLI](), you can inspect the status of the installation with the following
command, executed on the Landscaper data cluster:

```shell
landscaper-cli inst inspect -n example hello-world
```

Alternatively, you can check the Installation and its DeployItem directly:

```shell
kubectl get inst -n example hello-world
kubectl get di -n example hello-world-...
```

On the target cluster, you should find the deployed ConfigMap:

```shell
kubectl get configmap -n example hello-world
```
