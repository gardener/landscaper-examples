# Helm Example With a Never Ending Pre-Install Hook

The Installation in this example deploys a helm chart with a pre-install helm hook. 
The job with the pre-install annotation uses a pause image that does not finish.

## How to reproduce the helm error "another operation is in progress" 

1. Create the installation.
2. While the pre-install hook is running, restart the pod of the helm deployer.
3. The next reconciliation of the deploy item will fail with the error message `another operation (install/upgrade/rollback) is in progress`.
