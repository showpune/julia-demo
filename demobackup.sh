#update the extension
#az extension remove -n containerapp
#az extension add --source ./containerapp-0.3.66-py2.py3-none-any.whl

az account set --subscription d0822b01-62ea-4eb9-885b-95c60e4250b4
#extension=./containerapp-0.3.66-py2.py3-none-any.whl
jarpath=./sample/spring-petclinic-api-gateway/target/spring-petclinic-api-gateway-3.0.2.jar
jarapp=api-gateway
sourcepath=./sample/spring-petclinic-customers-service/
sourceapp=customers-service
#git-url= 


#enviroment=julia-demo-env
#rg=zhiyongli-test-group
enviroment=zhiyong-test-appenv
rg=zhiyongli-test
subscription=d0822b01-62ea-4eb9-885b-95c60e4250b4
registryserver=zhiyongacr.azurecr.io
registryuser=zhiyongacr
registerpass=VFLqULNk9jk0QHYiolNJzdheq9+XTUg4Pn+1vAaPJ8+ACRA0Snb4

# enable java component
az containerapp env show -n $enviroment -g $rg
az containerapp env java-component list --environment $enviroment -g $rg
az containerapp env java-component spring-cloud-config create -n myconfig -g $rg --environment $enviroment --subscription $subscription --yaml ./config.yaml
az containerapp env java-component spring-cloud-eureka create -n myeureka -g $rg --environment $enviroment --subscription $subscription --enable-dashboard
az containerapp env java-component spring-boot-admin create -n mysba -g $rg --environment $enviroment --subscription $subscription --enable-dashboard

az containerapp env java-component list --environment $enviroment -g $rg | jq '.[]|  [.name,.resourceGroup,.properties.configuration.ingress.fqdn]'



echo "Deploy the app from jar with -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8080 --subscription $subscription"

az containerapp create -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8080 --subscription $subscription --min-replicas 1 --max-replicas 1 --env-vars "EUREKA_INSTANCE_APPNAME=api-gateway" --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass --bind-java-component myeureka mysba myconfig

echo "Deploy the app from source with -n $sourceapp -g $rg  --environment $enviroment --source $sourcepath --ingress external --target-port 8080 --subscription $subscription"

az containerapp create -n $sourceapp -g $rg  --environment $enviroment --source $sourcepath --ingress external --target-port 8080 --subscription $subscription --min-replicas 1 --max-replicas 1 --env-vars "EUREKA_INSTANCE_APPNAME=customers-service" --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass --bind-java-component myeureka mysba myconfig

az containerapp list -g $rg  --subscription $subscription  --environment $enviroment -o table 


