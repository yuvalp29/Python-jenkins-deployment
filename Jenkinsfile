pipeline {
    environment {
    commit_id          = ""
	  ustomImage         = ""
	  registry           = "yp29/jenkinsmultibranch"
	  registryCredential = "dockerhub"
    }

    agent { label 'slave01-ssh' }

    stages {
      stage('Prepare') {
        steps {
  		    sh "echo Preparations are running."
          checkout scm  
  		    script{
            sh "git rev-parse --short HEAD > .git/commit-id"
            commit_id = readFile('.git/commit-id').trim()
            }
        }
      }
      stage('Mail') {
        steps {
          mail(subject: 'Status "Automated actions"', body: 'Script is running', from: 'ypodoksik29@gmail.com', to: 'ypodoksik29@gmail.com')
        }
      }
    }
} 