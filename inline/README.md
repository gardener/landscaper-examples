# Examples with Inline Blueprint or Inline Component Descriptor

### Example [helm/installation-1](helm/installation-1)

The blueprint is defined inline within the installation.  
The helm chart data (repo, name, version) are hardcoded in the blueprint.  
The helm values are hardcoded in the inline blueprint.

### Example [helm/installation-2](helm/installation-2)

Similar to the previous example.  
The helm values are now imported from a data object.

### Example [helm/installation-3](helm/installation-3)

Similar to the previous example.  
The installation contains an inline component descriptor.  
The helm chart and the container image are resources in the component descriptor.  
The blueprint references the resources in the component descriptor.
