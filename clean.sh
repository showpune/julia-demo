enviroment=zhiyongli-test-env
rg=zhiyongli-test-group
subscription=d0822b01-62ea-4eb9-885b-95c60e4250b4
registryserver=zhiyongacr.azurecr.io
registryuser=zhiyongacr
registerpass=$1

az containerapp delete -n customers-service -g $rg  --subscription $subscription --yes
az containerapp delete -n api-gateway -g $rg  --subscription $subscription --yes
az containerapp list -g $rg  --subscription $subscription  --environment $enviroment -o table 