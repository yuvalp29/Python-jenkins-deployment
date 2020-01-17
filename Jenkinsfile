pipeline {
    environment {
    commit_id          = ""
	  ustomImage         = ""
	  registry           = "yp29/pythondeploy"
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
      stage("Gather Deployment Parameters") {
        steps {
          timeout(time: 30, unit: 'SECONDS') {
            script {
              // Show the select input modal
              def INPUT_PARAMS = input message: 'Please Provide Parameters', ok: 'Next',
              parameters: [
                choice(name: 'ENVIRONMENT', choices: ['dev','qa'].join('\n'), description: 'Please select the Environment'),
                choice(name: 'IMAGE_TAG', choices: getDockerImages(), description: 'Available Docker Images')]
              env.ENVIRONMENT = INPUT_PARAMS.ENVIRONMENT
              env.IMAGE_TAG = INPUT_PARAMS.IMAGE_TAG
            }
          }
        }
      }
      stage("Use Deployment Parameters") {
        steps {
          script {
            echo "All parameters have been set as Environment Variables"
            echo "Selected Environment: ${env.ENVIRONMENT}"
            echo "Selected Tag: ${env.IMAGE_TAG}"
          }
        }
      }
    }
}