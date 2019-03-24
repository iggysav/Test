pipeline {
    agent { node { label 'slave02' } }
    parameters {
        
        string(name: 'range_ip', defaultValue: '192.168.43.0/24', description: 'Check ip-range (x.x.x.x/xx)')
        booleanParam(name: 'git_update', defaultValue: true, description: 'Do we need update git branche?')
        text(name: 'result', defaultValue:'')
    }
    environment {          
        def RANGE = "${params.range_ip}"
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
                nmap -sP 192.168.43.0/24 >> online_hosts.txt
                sudo apt-get remove nmap -y 
                '''
                ${params.result} = cat online_hosts.txt
               // sh "cat online_hosts.txt"
            }
        }
        stage('Git update') {
            when {
                expression {params.git_update == true}
            }
            steps {
                sh '''
                    git add --all                     
                    git commit -m "New list online hosts"
                    git push
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
                slackSend (color: '#00FF00', message: "${params.result}")
            }
            failure {
                slackSend (color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
            }
    }
}
