pipeline {
  environment {
  commit_id          = ""
  ustomImage         = ""
  docker_name        = "docker-python-app"
  registry           = "yp29/pythondeploy"
  rep_name           = "pythonapp"
  registryCredential = "dockerhub"
  }

  agent { label 'slave01-ssh' }

  stages {
    stage("Preparation") {
      steps {
        sh "echo Preparations are running."
        checkout scm  
        script{
          sh "git rev-parse --short HEAD > .git/commit-id"
          commit_id = readFile('.git/commit-id').trim()
          }
      }
    }
    stage('Build/Push latest image') {
      when{ 
        anyOf { 
					branch "Python-Deploy"; branch "Ansible-Deploy"; branch "Kubernetes-Deploy"
        }
      }
      steps{
        sh "echo Build/Publish the latest version is running."
        script{
          customImage = docker.build(registry + ":${rep_name}-latest", "./DockerFiles")
          docker.withRegistry( '', registryCredential ) {
            customImage.push()
          }
        }
      }
    }
    stage("Python ws Deployment"){
      when{ 
        branch "Python-Deploy"
      }
      steps{
					sh "chmod +x ./scripts/Deploy_ws.sh"
          sh "./scripts/Deploy_ws.sh ${docker_name} ${registry} ${rep_name} latest"
          sh "echo Web Server lunched successfuly"
      }
    }
    stage('Ansible Test') {
      when{ 
        branch "Ansible-Deploy"
      }
      steps{
        sh "echo Ansible tests are running."
          sh "ansible-playbook -i ./Inventory/hosts.ini -u jenkins ./ymlFiles/TestConnection.yml"
      }
    }
    stage('Ansible Installations') {
      when{ 
        branch "Ansible-Deploy"
      }
      steps{
        sh "echo Ansible installations are running."
        sh "ansible-playbook -i ./Inventory/hosts.ini -u jenkins ./ymlFiles/Prerequisites.yml"
      }
    }
    stage('Ansible Deployment') {
      when{ 
        branch "Ansible-Deploy"
      }
      steps{
        sh "echo Ansible deployment is running."
        sh "ansible-playbook -i ./Inventory/hosts.ini -u jenkins ./ymlFiles/Ansible-Deploy.yml"
      }
    }
    stage("Kubernetes Deployment") {
      agent { label 'k8s' }
      when{ 
        branch "Kubernetes-Deploy"
      }
      steps{
        sh "echo Kubernetes deployment is running."
        sh "chmod +x ./scripts/k8s_Deploy.sh"
        sh "./scripts/k8s_Deploy.sh"
      }
    }
    stage("Build/Push base image") {
      when{ 
        anyOf { 
					branch "Python-Deploy"; branch "Ansible-Deploy"; branch "Kubernetes-Deploy"
        }
      }
      steps{
        sh "echo Build/Publish the base version is running."
        script{
          customImage = docker.build(registry + ":${rep_name}-base", "./DockerFiles")
          docker.withRegistry( '', registryCredential ) {
            customImage.push()
          }
        }
      }
    }
    stage("Cleanup") {
      steps{
        sh "echo Cleanup stage is running."
        sh "docker image prune -af"
      }
    }
  }
}