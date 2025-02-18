# Terraform GCP GKE Project

Este projeto configura um cluster Kubernetes (GKE) no Google Cloud Platform (GCP) usando Terraform. Ele também configura o monitoramento do cluster com Prometheus e Grafana, utilizando helm, esse repositório foi inspirado na live do Rafael Botelho e algumas dicas do Kalyan Reddy Daida
[Assista à live do Rafael Botelho](https://www.youtube.com/watch?v=3K1rswpWVQk&t=3827s) 

## Estrutura do Projeto

- `version.tf`: Define a versão do Terraform e do provedor Google.
- `provider.tf`: Configura o provedor Google com o ID do projeto e a região.
- `vpc.tf`: Configura a rede VPC e sub-redes.
- `nat.tf`: Configura o NAT para permitir o acesso à internet para instâncias privadas.
- `regras.tf`: Configura as regras de firewall.
- `datasource.tf`: Obtém as zonas disponíveis no GCP.
- `cluster.tf`: Configura o cluster GKE.
- `nodes.tf`: Configura o node pool do cluster GKE.
- `output.tf`: Define as saídas do Terraform.

## Pré-requisitos

- [Terraform](https://www.terraform.io/downloads.html) instalado.
- [Google Cloud SDK](https://cloud.google.com/sdk/docs/install) instalado.
- Credenciais de serviço do GCP configuradas.

## Configuração

1. **Configurar Credenciais do GCP**:
   ```sh
   export GOOGLE_APPLICATION_CREDENTIALS=/path/to/your/credentials.json
   ```

2. **Inicializar o Terraform**:
   ```sh
   terraform init
   ```

3. **Aplicar a Configuração do Terraform**:
   ```sh
   terraform apply
   ```

## Monitoramento com Prometheus e Grafana

1. **Habilitar a API do Kubernetes Engine**:
   ```sh
   gcloud services enable container.googleapis.com
   ```

2. **Adicionar o Repositório Helm do Prometheus**:
   ```sh
   helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
   helm repo update
   ```

3. **Criar o Namespace de Monitoramento**:
   ```sh
   kubectl create namespace monitoring
   ```

4. **Instalar o Prometheus e Grafana**:
   ```sh
   helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
   ```

5. **Encaminhar a Porta do Prometheus**:
   ```sh
   kubectl port-forward prometheus-prometheus-kube-prometheus-prometheus-0 9090 -n monitoring
   ```

6. **Configurar o Grafana como LoadBalancer**:
   ```sh
   kubectl edit service prometheus-grafana -n monitoring
   # Adicione `type: LoadBalancer` ao serviço
   ```

7. **Obter o IP do LoadBalancer do Grafana**:
   ```sh
   kubectl get service -n monitoring
   ```

8. **Obter a Senha do Admin do Grafana**:
   ```sh
   kubectl get secret prometheus-grafana -o jsonpath="{.data.admin-password}" -n monitoring | base64 --decode ; echo
   ```

## Outputs

- `cluster_name`: O nome do cluster criado.
- `node_name`: O nome do node pool criado.
- `cluster_location`: A localização do cluster criado.
- `cluster_endpoint`: O endpoint do cluster criado.
- `cluster_master_version`: A versão do master do cluster criado.
- `cluster_node_version`: A versão dos nodes do cluster criado.
- `cluster_node_id`: O ID do node pool criado.

## Referências

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Google Cloud Documentation](https://cloud.google.com/docs)
- [Prometheus Documentation](https://prometheus.io/docs/introduction/overview/)
- [Grafana Documentation](https://grafana.com/docs/grafana/latest/)

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo LICENSE para mais detalhes.
