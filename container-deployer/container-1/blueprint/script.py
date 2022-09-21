import sys
import os
import yaml

from kubernetes import client, config

def load_kube_config(imports: dict):
    kubeconfig = yaml.safe_load(imports["targetCluster"]["spec"]["config"]["kubeconfig"])
    config.load_kube_config_from_dict(config_dict=kubeconfig)

def reconcile(imports: dict):
    configmap_import = imports["configmap"]
    name = configmap_import["name"]
    namespace = configmap_import["namespace"]
    configmap = {
        "apiVersion": "v1",
        "kind": "ConfigMap",
        "metadata": {
            "name": name 
        },
        "data": {
            configmap_import["content"]["key"]: configmap_import["content"]["value"]
        }
    }

    v1 = client.CoreV1Api()
    res = list(v1.list_namespaced_config_map(namespace=namespace, watch=False, field_selector=f"metadata.name={name}").items)
    
    if len(res) == 0:
        print(f"create configmap {namespace}/{name}")
        v1.create_namespaced_config_map(namespace=namespace, body=configmap)
    else:
        print(f"updating configmap {namespace}/{name}")
        v1.replace_namespaced_config_map(namespace=namespace, name=name, body=configmap)

    res = list(v1.list_namespaced_config_map(namespace=namespace, watch=False, field_selector=f"metadata.name={name}").items)
    return res[0].data

def delete(imports: dict):
    configmap_import = imports["configmap"]
    name = configmap_import["name"]
    namespace = configmap_import["namespace"]

    v1 = client.CoreV1Api()
    res = list(v1.list_namespaced_config_map(namespace=namespace, watch=False, field_selector=f"metadata.name={name}").items)
    
    if len(res) > 0:
        print(f"deleting configmap {namespace}/{name}")
        v1.delete_namespaced_config_map(namespace=namespace, name=name)

def write_exports(configmap_data: dict, components: dict, content_path: str, exports_path: str):
    print(f"writing exports to {exports_path}")

    component = components["components"][0]
    content_files = next(os.walk(content_path), (None, None, []))[2]
    content = []

    for file in content_files:
        abs_path = os.path.join(content_path, file)
        print(f"accessing {abs_path}")
        stat = os.stat(abs_path)
        content.append({
            "name": file,
            "stat": {
                "size": stat.st_size,
                "mode": stat.st_mode,
                "uid": stat.st_uid,
                "gid": stat.st_gid
            }
        })

    exports = {
        "configMapData": configmap_data,
        "component": {
            "name": component["component"]["name"],
            "version": component["component"]["version"]
        },
        "content": content,
    }
    with open(exports_path, 'w') as f:
        f.write(yaml.safe_dump(exports))

def main(argv=None):
    imports_path = os.environ["IMPORTS_PATH"]
    exports_path = os.environ["EXPORTS_PATH"]
    component_descriptor_path = os.environ["COMPONENT_DESCRIPTOR_PATH"]
    content_path = os.environ["CONTENT_PATH"]
    operation = os.environ["OPERATION"]

    print(f"imports_path={imports_path}")
    print(f"exports_path={exports_path}")
    print(f"component_descriptor_path={component_descriptor_path}")
    print(f"content_path={content_path}")
    print(f"operation={operation}")

    with open(imports_path, 'r') as f:
        imports = yaml.safe_load(f.read())

    with open(component_descriptor_path, 'r') as f:
        components = yaml.safe_load(f.read())

    load_kube_config(imports)

    if operation.lower() == "reconcile":
        configmap_data = reconcile(imports)
        write_exports(configmap_data, components, content_path, exports_path)
    else:
        delete(imports)

    return 0

if __name__ == "__main__":
    sys.exit(main())
