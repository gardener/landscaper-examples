# Signing Component Descriptors

We assume that all the component descriptors for the sock-shop components have already been pushed to the OCI
registry.

Script `./sign.sh` reads the component descriptors, signs them and pushes them again using the modified base URL
`<original base url>/signed`.

Script `./remote-get.sh` downloads all these signed component descriptors to the `cd-....yaml` files in the current
directory.

Script `./verify.sh` computes the digest of the component descriptor, checks that it matches the digest in the 
component descriptor and verifies the signature. 
