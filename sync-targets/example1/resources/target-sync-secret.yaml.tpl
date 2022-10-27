<%
  with open(kubeconfig_path) as f:
    lines = f.readlines()

  lines = map(str.rstrip, lines)
%>
apiVersion: v1
kind: Secret
metadata:
  name: ${name}
  namespace: ${namespace}
type: Opaque
stringData:
  kubeconfig: |
% for line in lines:
    ${line}
% endfor
