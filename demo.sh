#
extension=./containerapp-0.3.66-py2.py3-none-any.whl
jarpath=./sample/spring-petclinic-api-gateway/target/spring-petclinic-api-gateway-3.0.2.jar
jarapp=api-gateway
sourcepath=./sample/spring-petclinic-customers-service/
sourceapp=customers-service
#git-url= 

#update the extension
#az extension remove -n containerapp
#az extension add --source $extension

enviroment=shiqiu-test-env-01
rg=shiqiu-test-rg-01
subscription=d0822b01-62ea-4eb9-885b-95c60e4250b4
registryserver=zhiyongacr.azurecr.io
registryuser=zhiyongacr
registerpass=$1

# set resource id
# #echo 'Enable the spring cloud config'
# configresourceid=$(az containerapp env spring-cloud-config enable --git-url $git-url | jq -r '.configResourceId')
# echo 'Enable the spring cloud Eureka'
# eurekaresourceid=$(az containerapp env spring-cloud-eureka enable | jq -r '.eurekaResourceId')
# echo 'Enable the spring boot admin'
# adminresourceid=$(az containerapp env spring-boot-admin enable | jq -r '.adminResourceId')

echo "Deploy the app from jar with -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8080 --subscription $subscription"

az containerapp create -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8080 --subscription $subscription --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass 
##--bind-java-component myeureka mysba myconfig

#echo "Deploy the app from source with -n $sourceapp -g $rg  --environment $enviroment --source $sourcepath --ingress external --target-port 8080 --subscription $subscription"

#az containerapp create -n $sourceapp -g $rg  --environment $enviroment --source $sourcepath --ingress external --target-port 8080 --subscription $subscription --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass --bind-java-component myeureka mysba myconfig

az containerapp list -g $rg  --subscription $subscription  --environment $enviroment -o table 


