package main

import "fmt"

type Instance string
type Config string
type Target string

func main() {

	const (
		red    = "red"
		blue   = "blue"
		green  = "green"
		yellow = "yellow"
		orange = "orange"
	)

	// data objects and targets in the root context

	instances := []Instance{red, green, blue, yellow, orange}

	configs := map[Instance]Config{
		red:    "12",
		blue:   "34",
		green:  "56",
		yellow: "78",
		orange: "90",
	}

	clusters := map[Instance]Target{
		red:    Target("red-cluster"),
		blue:   Target("blue-cluster"),
		green:  Target("green-cluster"),
		yellow: Target("yellow-cluster"),
		orange: Target("orange-cluster"),
	}

	// root installation
	InstallAllInstances(instances, configs, clusters)
}

// InstallAllInstances : blueprint to install several instances
func InstallAllInstances(instances []Instance, configs map[Instance]Config, clusters map[Instance]Target) {
	for _, instance := range instances {
		config := configs[instance]
		target := clusters[instance]

		// sub installation
		InstallSingleInstance(instance, config, target)
	}
}

// InstallSingleInstance : blueprint to install a single instance
func InstallSingleInstance(instance Instance, config Config, cluster Target) {
	fmt.Printf("installing instance %6s with config %2s on cluster %14s \n", instance, config, cluster)
}
