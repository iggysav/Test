pipeline {
    agent { node { label 'slave02' } }
    parameters {
        
        string(name: 'range_ip', defaultValue: '192.168.43.0/24', description: 'Check ip-range (x.x.x.x/xx)')
        booleanParam(name: 'git_update', defaultValue: true, description: 'Do we need update git branche?')
        text(name: 'result', defaultValue:'')
    }
    environment {          
        def RANGE = "${params.range_ip}"
        def RESULT = "${params.result}"
    }

    stages {
        stage('Clone') {
            steps {
                git url: "https://github.com/iggysav/Test.git", branch: "nmap"
            }
        }
    
        stage('Run script') {
            steps {
                sh '''
                sudo apt-get install nmap -y 
                nmap -sP ${RANGE} >> online_hosts.txt
                sudo apt-get remove nmap -y 
                '''
            }
        }
        stage('Test') {
            steps {
              script {
            RESULT = sh(returnStdout: true, script: 'cat online_hosts.txt')
        }
      }
    }
        stage('output_version') {
            steps {
            echo "awesomeVersion: ${RESULT}"
      }
    }
        
        
        stage('Git update') {
            when {
                expression {params.git_update == true}
            }
            steps {
                sh '''
                    git config --global user.email "igor.savastsiuk@it-academy.by"
                    git config --global user.name "Iggy Sav"
                    git add --all                     
                    git commit -m "New list online hosts"
                    git push --set-upstream origin nmap
                '''
            }
        }
        
        stage('Git no update. View output file') {
            when {
                expression {params.git_update == false}
            }
            steps {
                sh "cat ./online_hosts.txt"
            }
        }

        stage('Packing test') {
            steps {
                sh "ls -l"
            }
        }        
    
        stage('Delete local rep'){
            steps{
                deleteDir()
            }
        }
    }
    post {
            success {
                slackSend (color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL}) ver:${env.BUILD_ID}")
                slackSend (color: '#00FF00', message: "${env.RESULT}")
            }
            failure {
                slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
    }
}
