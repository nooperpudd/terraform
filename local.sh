#!/usr/bin/env bash

if ! command -v terraform ; then echo terraform not installed ;  exit 0 ; fi
if ! command -v docker ; then echo docker not installed ;  exit 0 ; fi
if ! command -v docker-compose ; then echo docker-compose not installed ;  exit 0 ; fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

init_vault(){
# create secrets
docker-compose up -d vault
sleep 2
docker exec -ti terraform_vault_1 sh -c "export VAULT_TOKEN=root ; vault kv put -address http://127.0.0.1:8200 secret/helm/kubewatch slack_token=foo"
sleep 2
docker exec -ti terraform_vault_1 sh -c "export VAULT_TOKEN=root ; vault kv put -address http://127.0.0.1:8200 secret/helm/prometheus slack_token=foo"
sleep 2
echo """
set the following in your /etc/hosts:
127.0.0.1 vault-k8s.ENV.ZONE.com
"""
}

init_postgres(){
# create vault and postgres backends
POSTGRES_ADDRESS=localhost
POSTGRES_USER=terraform
POSTGRES_PASSWORD=terraform
export POSTGRES_PASSWORD=$POSTGRES_PASSWORD
docker-compose up -d postgres

# terraform init backend
cd "$DIR"/kubernetes || exit
terraform init -backend-config="conn_str=postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_ADDRESS/terraform_backend?sslmode=disable" || echo "Done !"
terraform workspace new default || if [ $? -eq 0 ]; then echo "Done !"; else echo "Workspace \"default\" was not created"; fi
terraform init
}

"$@"
