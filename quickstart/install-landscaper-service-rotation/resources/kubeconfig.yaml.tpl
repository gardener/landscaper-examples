apiVersion: v1
kind: Config
current-context: "${cluster}--${username}"
contexts:
  - name: "${cluster}--${username}"
    context:
      cluster: ${cluster}
      user: ${username}
      % if namespace:
      namespace: ${namespace}
      % endif
clusters:
  - name: ${cluster}
    cluster:
      % if ca_data:
      certificate-authority-data: ${ca_data}
      % endif
      server: ${server}
users:
  - name: ${username}
    user:
      token: ${token}
