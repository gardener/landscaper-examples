package main

import "fmt"

type InstanceID string

type Config string
type Configs map[InstanceID]Config

type Scheduling map[InstanceID]TargetKey

type TargetKey string
type Target string
type TargetMap map[TargetKey]Target

func main() {

	const (
		// instances
		red    = "red"
		blue   = "blue"
		green  = "green"
		yellow = "yellow"
		orange = "orange"

		// target keys
		north = "north"
		east  = "east"
		south = "south"
		west  = "west"
	)

	// data objects in the root context

	instances := []InstanceID{red, green, blue, yellow, orange}

	configs := Configs{
		red:    "12",
		blue:   "34",
		green:  "56",
		yellow: "78",
		orange: "90",
	}

	scheduling := Scheduling{
		red:    north,
		blue:   north,
		green:  south,
		yellow: south,
		orange: west,
	}

	clusters := TargetMap{
		north: Target("north-cluster"),
		east:  Target("east-cluster"),
		south: Target("south-cluster"),
		west:  Target("west-cluster"),
	}

	// root installation
	InstallAllInstances(instances, configs, scheduling, clusters)
}

// blueprint of the root installation
func InstallAllInstances(instances []InstanceID, configs map[InstanceID]Config, scheduling Scheduling, clusters TargetMap) {
	for _, instance := range instances {
		config := configs[instance]
		targetKey := scheduling[instance]
		target := clusters[targetKey]

		// sub installation
		InstallSingleInstance(instance, config, target)
	}
}

// blueprint of the sub installation
func InstallSingleInstance(instance InstanceID, config Config, cluster Target) {
	fmt.Printf("installing instance %q with config %q on cluster %q \n", instance, config, cluster)
}
