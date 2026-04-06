pipeline {
    agent any
    
    environment {
        DOCKER_USER = 'milinxgenix' 
        IMAGE_NAME = 'rivera-web-app'
        FULL_IMAGE = "${DOCKER_USER}/${IMAGE_NAME}:${env.BUILD_ID}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Docker Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-creds', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                    // Use 'bat' for Windows commands
                    bat "docker build -t ${FULL_IMAGE} ."
                    bat "echo %PASS% | docker login -u %USER% --password-stdin"
                    bat "docker push ${FULL_IMAGE}"
                }
            }
        }

        stage('K8s Deployment') {
            steps {
                script {
                    // Using powershell for the text replacement on Windows
                    powershell "(Get-Content deployment.yaml) -replace 'IMAGE_PLACEHOLDER', '${FULL_IMAGE}' | Set-Content deployment.yaml"
                    bat "kubectl apply -f deployment.yaml"
                }
            }
        }
    }
}
