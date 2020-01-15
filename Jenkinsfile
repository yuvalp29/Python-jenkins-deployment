pipeline {
  agent {
    node {
      label 'slave1-ssh'
    }

  }
  stages {
    stage('') {
      steps {
        mail(subject: 'Status "Automated actions"', body: 'Script is running', from: 'ypodoksik29@gmail.com', to: 'ypodoksik29@gmail.com')
      }
    }
  }
}