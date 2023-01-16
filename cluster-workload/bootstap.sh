echo "Creating monitoring namespace"
kubectl create namespace monitoring || true

echo "Creating services namespace"
kubectl create namespace services || true

echo "Deploying Backend"
kubectl apply -f ./backend_deployment.yaml
kubectl wait --for condition=Available=True deployment backend -n services --timeout=60s

echo "Deploying Frontend"
kubectl apply -f ./frontend_deployment.yaml
kubectl wait --for condition=Available=True deployment frontend -n services --timeout=60s

#Add the Prometheus and Grafana chart repository and update the local cache:
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

echo "Deploying Prometheus"
helm upgrade --namespace monitoring --install prometheus prometheus-community/kube-prometheus-stack --wait

echo "Deploying Grafana"
helm upgrade --namespace monitoring --install grafana grafana/grafana --wait

echo "Exposing Grafana to Internet"
kubectl expose deployment grafana --type=LoadBalancer --name=grafana-ext --namespace monitoring

echo "Fetching admin user password"
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo