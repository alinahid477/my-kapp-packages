***Custom apps are sourced from dockerhub: image pull from docker.io/accordingtoali/simple-greetings:1.0.0 which without docker auth fails with dockerhub's rate-limit issue. To overcome this need to create dockurhub regcred in that the target namespace:default and accociate the imagepull secret with service account:package-deployer. The service account is used in the deployment definition.***

kubectl create secret docker-registry dockerhubregkey --docker-server=https://index.docker.io/v2/ --docker-username=<dockerhub username> --docker-password=<dockerhubpassword> --docker-email=your@email.com --namespace default

kubectl create secret docker-registry dockerhubregkey --docker-server=https://index.docker.io/v2/ --docker-username=<dockerhub username> --docker-password=<dockerhubpassword> --docker-email=your@email.com --namespace tanzu-package-repo-global

kubectl apply -f rolebinding.yaml
kapp deploy -a anahid-custom-kapp-repo -f packaging/repository.yaml -y -n tanzu-package-repo-global