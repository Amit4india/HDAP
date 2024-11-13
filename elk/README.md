Steps:
1. Use the helm repo for the elsatic.io URL: https://github.com/elastic/helm-charts
2. Using helm3
3. tag used 7.8.1
3. Customized the values.yaml file for various components.
4. Run the below commands to generate the kubernetes deployment scripts.
- helm install elasticsearch ./elasticsearch --dry-run --namespace=elk
- helm install kibana ./kibana --dry-run --namespace=elk
- helm install logstash ./logstash --dry-run --namespace=elk
- helm install filebeat ./filebeat --dry-run --namespace=elk
5. Copy the output in the k8config files.
6. Used the file to setup ELK stack.
