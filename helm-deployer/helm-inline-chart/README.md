# Inline Helm Chart

**This feature is no longer supported.**

Package the helm chart: `helm package <chart directory>`.
Base64 encode the chart archive: `base64 -i <path to chart archive> -o <output file>`.
Insert the base64 encoded chart archive into the Installation.
