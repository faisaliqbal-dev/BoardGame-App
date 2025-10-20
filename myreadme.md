
# SERVERS
3 server for master and slave k8s 
1 for Jenkins in which docker should be installed and trivy also
1 for sonarqube in which docker should be installed 
1 for nexus in which docker should be installed 

# PLUGINS 
pipeline view
eclipse installer 
config file provider
pipeline maven integration
SonarQube scanner
docker
docker pipeline
Kubernetes , k8s cli , k8s credentials , k8s api
maven integration

# Tools Config in manage jenkins > configure tools
jdk 17 , aut install .net 17
sonar-scanner , latest
maven , select latest
docker , install au , install docker.com 



## ✅ CI/CD Pipeline Stages
pipeline {
agent any
tools {
}jdk "jdk17"  #defining java and maven version according to our configtools in manage jenkins
maven "maven"

environemet {
SCANNER_HOME= tool "sonar-scanner"
}

1. **Git Checkout**
   - Pulls source code from GitHub (`main` branch)

2. **Compile**
   - Compiles Java code using Maven

3. **Test**
   - Runs unit tests using `mvn test`

4. **File System Scan**
   - Scans file system for vulnerabilities using **Trivy**

5. **SonarQube Analysis**
     credential for sonarqube create token and paste it in our jenkins credential as secret test as sonarqube-credential
     now go to system scrol down check sonarqube give name as sonar 
     paste your sonar ec2  ip and select your credentials
     now create sonarqube pipeline using pipeline syntax choose sonarqubeenv and copy then give project name as well as project key and binaries
   - Runs static code analysis using `sonar-scanner`

6. **Quality Gate**
     quality gates means ke SonarQube ke shrto ku milna ke code quality aisi rahena wara error, to uske waste got to SonarQube > configuration > webhooks create webshook > name > Jenkins > url give jenkisn url with /sonarqube-webhook/ > create

   - Waits for SonarQube's Quality Gate to pass

7. **Build Package**
   - Packages application into a `.jar`

8. **Build & Tag Docker Image**
   - Builds Docker image and tags it as `latest`

9. **Push to DockerHub**
   - Pushes Docker image to DockerHub repo

10. **Deploy to Kubernetes**

    eks rbac 
    in screenshot create account in namespace webapp in master node for performing deployment 
    first file is svc.yml
    second is role.yml in same namespace 
    third one is bind.yml for binding role to user
    go to browser search >  k8s additional api token 
    nano secret.yml  > service account name give as Jenkins >  run this file in -n webapps

    kubectl describe mysecretname -n webapps  > a secrect token will generate

    this will give you a token for connecting or authenticateJenkins and k8s copy token and
    now come to Jenkins > manage Jenkins > credentials > secret text > secret paste token > ID > k8s cred > save 
   
    now pipeline syntanx  withkubeconfig cli
    select credentials k8s-cred
    k8s server endpoint {
    now go to master k8s cd ~/.kube > ls > cat config > copy server end point(server > ip-add) > paste > cluster name Kubernetes > namespace > webpass
    }

    - Applies `deployment-service.yaml` to deploy app on K8s worker nodes

11. **Verify Deployment**
    - Lists pods and services in the `webapps` namespace

---

## ⚙️ Prerequisites

- Jenkins setup with plugins:
  - Maven Integration
  - Docker Pipeline
  - Kubernetes CLI Plugin
  - SonarQube Scanner
- SonarQube Server with a project token
- DockerHub account and credentials in Jenkins
- Kubernetes Cluster (1 Master + Worker Nodes)
- Trivy installed on Jenkins agent

---

## 🔐 Jenkins Credentials Used

- `sonar-token` – SonarQube authentication token
- `dockerhub-credentials` – DockerHub username/password
- `k8s-cred` – Kubernetes config credentials

---

## 🧠 Kubernetes Deployment

- App is deployed to namespace: `webapps`
- Deployment + Service defined in `deployment-service.yaml`
- Worker nodes run the actual application containers

---

## 📌 Outcome

✅ Fully automated CI/CD pipeline  
✅ Static code analysis and security checks integrated  
✅ Dockerized Java app deployed to Kubernetes cluster

---

## 📷 Screenshot (Optional)

> Add `kubectl get pods` or Jenkins pipeline screenshot here if needed.

---

## 🙏 Special Thanks

Thanks to the open-source community and the original app repository:  
🔗 [https://github.com/faisaliqbal-dev/BoardGame-App](https://github.com/faisaliqbal-dev/BoardGame-App)

---

