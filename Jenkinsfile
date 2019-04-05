pipeline {
    environment {
        registry = "iggysav/test01"
    }
    agent { node { label 'slave02' } }
    stages {
        stage('Cloning Git') {
            steps {
               git 'git@github.com:iggysav/test01.git' 
            }
        }
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerHub') {
                        dockerImage.push()
                    }
                }
                
            }
        }
        
        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}
