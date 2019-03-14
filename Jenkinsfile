pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git url: "git@github.com:iggysav/Test.git"
            }
        }
        stage('Checking') {
            steps {
                sh "ls -l"
            }
        }
        stage('Packing project') {
            steps {
                sh '''
                tar -zcvf /tmp/package.tar.gz  ./
                '''
                deleteDir()
                sh "mv /tmp/package.tar.gz  ./"
            }
        }
        stage('Packing test') {
            steps {
                sh "ls -l"
            }
        }        
    
    }
}
