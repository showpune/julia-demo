enviroment=julia-demo-env
rg=zhiyongli-test-group
# enviroment=shiqiu-test-env-01
# rg=shiqiu-test-rg-01
subscription=d0822b01-62ea-4eb9-885b-95c60e4250b4
registryserver=zhiyongacr.azurecr.io
registryuser=zhiyongacr

az containerapp delete -n customers-service -g $rg  --subscription $subscription --yes
az containerapp delete -n api-gateway -g $rg  --subscription $subscription --yes
az containerapp env java-component spring-cloud-config delete --name myconfig -g $rg --subscription $subscription --yes
az containerapp env java-component spring-cloud-eureka delete --name myeureka -g $rg --subscription $subscription --yes
az containerapp env java-component spring-boot-admin delete --name mysba -g $rg --subscription $subscription --yes
az containerapp list -g $rg  --subscription $subscription  --environment $enviroment -o table 