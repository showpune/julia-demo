enviroment=zhiyongli-test-env
rg=zhiyongli-test-group
subscription=d0822b01-62ea-4eb9-885b-95c60e4250b4
registryserver=zhiyongacr.azurecr.io
registryuser=zhiyongacr
registerpass=$1


jarpath=/mnt/c/IdeaProjects/spring-petclinic-microservices/spring-petclinic-config-server/target/spring-petclinic-config-server-3.0.2.jar
jarapp=config-server
az containerapp create -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8888 --subscription $subscription --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass
jarpath=/mnt/c/IdeaProjects/spring-petclinic-microservices/spring-petclinic-discovery-server/target/spring-petclinic-discovery-server-3.0.2.jar
jarapp=discovery-server
az containerapp create -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8671 --subscription $subscription --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass
jarpath=/mnt/c/IdeaProjects/spring-petclinic-microservices/spring-petclinic-admin-server/target/spring-petclinic-admin-server-3.0.2.jar
jarapp=admin-server
az containerapp create -n $jarapp -g $rg  --environment $enviroment --source $jarpath --ingress external --target-port 8080 --subscription $subscription --registry-server $registryserver --registry-user $registryuser --registry-pass $registerpass

az containerapp list -g $rg  --subscription $subscription  --environment $enviroment -o table 